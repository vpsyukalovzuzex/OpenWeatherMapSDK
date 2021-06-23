
import Foundation
import Alamofire

public class RequestBuilder {
    
    internal var method: Method
    
    internal var parameters: [String: String]
    
    internal var invalidFunctionError: Error?
    internal var missingFunctionError: Error?
    
    public init(_ method: Method) {
        self.method = method
        self.parameters = [String: String]()
    }
    
    // MARK: - Public func
    
    @discardableResult
    public func units(_ units: Units) -> Self {
        switch units {
        case .standard:
            break
        default:
            parameters[Key.units.rawValue] = units.rawValue
        }
        return self
    }
    
    @discardableResult
    public func language(_ language: Language) -> Self {
        parameters[Key.lang.rawValue] = language.rawValue
        return self
    }
    
    @discardableResult
    public func city(name: String, stateCode: String? = nil, countryCode: String? = nil) -> Self {
        let result = [name, stateCode, countryCode].compactMap { $0 }.joined(separator: ",")
        parameters[Key.q.rawValue] = result
        return self
    }
    
    @discardableResult
    public func id(_ id: String) -> Self {
        parameters[Key.id.rawValue] = id
        return self
    }
    
    @discardableResult
    public func coordinates(lat: Float, lon: Float) -> Self {
        parameters[Key.lat.rawValue] = String(lat)
        parameters[Key.lon.rawValue] = String(lon)
        return self
    }
    
    @discardableResult
    public func zip(_ zip: String) -> Self {
        parameters[Key.zip.rawValue] = zip
        return self
    }
    
    @discardableResult
    public func rectangle(lonLeft: Float, latBottom: Float, lonRight: Float, latTop: Float, zoom: Int = 10) -> Self {
        parameters[Key.bbox.rawValue] = "\(lonLeft),\(latBottom),\(lonRight),\(latTop),\(zoom)"
        return self
    }
    
    @discardableResult
    public func circle(_ number: Int) -> Self {
        let cnt = number <= 0 ? 1 : (number > 50 ? 50 : number)
        parameters[Key.cnt.rawValue] = String(cnt)
        return self
    }
    
    @discardableResult
    public func exclude(_ excludes: [Exclude]) -> Self {
        let result = Array(Set(excludes)).map { $0.rawValue }.joined(separator: ",")
        parameters[Key.exclude.rawValue] = result
        return self
    }
    
    @discardableResult
    public func limit(_ limit: Int) -> Self {
        parameters[Key.limit.rawValue] = "\(limit)"
        return self
    }
    
    @discardableResult
    public func request<T: Decodable>(_ type: T.Type, _ block: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        checkInvalidFunctions()
        if let error = invalidFunctionError {
            block(.failure(error))
            return nil
        }
        checkMissingFunctions()
        if let error = missingFunctionError {
            block(.failure(error))
            return nil
        }
        if let error = check(type) {
            block(.failure(error))
            return nil
        }
        guard let url = buildUrl() else {
            block(.failure(OWMError.urlIsWrong))
            return nil
        }
        let queue = DispatchQueue(label: "OpenWeatherMapSDK", qos: .userInitiated, attributes: .concurrent)
        return AF.request(url).validate().responseDecodable(of: type, queue: queue) { response in
            if let error = response.error {
                guard
                    let data = response.data,
                    let jsonError = try? JSONDecoder().decode(JSONError.self, from: data)
                else {
                    block(.failure(error))
                    return
                }
                let owmError = OWMError.badResponce(
                    code: Int(jsonError.code) ?? error.responseCode ?? 400,
                    message: jsonError.message
                )
                block(.failure(owmError))
                return
            }
            guard let value = response.value else {
                block(.failure(OWMError.valueIsNil))
                return
            }
            block(.success(value))
        }.task
    }
    
    // MARK: - Private func
    
    private func checkInvalidFunctions() {
        let set = Set(parameters.keys)
        var keys: [Key]
        switch method {
        case .currentWeather:
            keys = [
                .bbox,
                .cnt,
                .exclude,
                .limit
            ]
        case .currentWeatherByRectangle:
            keys = [
                .q,
                .id,
                .lat,
                .zip,
                .cnt,
                .exclude,
                .limit
            ]
        case .currentWeatherByCircle:
            keys = [
                .q,
                .id,
                .zip,
                .bbox,
                .exclude,
                .limit
            ]
        case .oneCall:
            keys = [
                .q,
                .id,
                .zip,
                .cnt,
                .bbox,
                .limit
            ]
        case .direct:
            keys = [
                .id,
                .lat,
                .zip,
                .bbox,
                .cnt,
                .exclude,
                .units,
                .lang
            ]
        case .reverse:
            keys = [
                .q,
                .id,
                .zip,
                .bbox,
                .cnt,
                .exclude,
                .units,
                .lang
            ]
        }
        for key in keys {
            if set.contains(key.rawValue) {
                invalidFunctionError = OWMError.invalidFunction(
                    function: key.functionName,
                    method: "\(method)",
                    underlyingError: invalidFunctionError
                )
            }
        }
    }
    
    private func checkMissingFunctions() {
        let set = Set(parameters.keys)
        var keys: [Key] = []
        switch method {
        case .currentWeather:
            let isValid =
                set.contains(Key.q.rawValue)   ||
                set.contains(Key.id.rawValue)  ||
                set.contains(Key.lat.rawValue) ||
                set.contains(Key.zip.rawValue)
            if !isValid {
                missingFunctionError = OWMError.missingFunction(
                    function: Key.q.functionName,
                    method: "\(method)",
                    underlyingError: missingFunctionError
                )
            }
        case .currentWeatherByRectangle:
            keys = [
                .bbox
            ]
        case .currentWeatherByCircle:
            keys = [
                .cnt,
                .lat
            ]
        case .oneCall:
            keys = [
                .lat
            ]
        case .direct:
            keys = [
                .q
            ]
        case .reverse:
            keys = [
                .lat
            ]
        }
        for key in keys {
            if !set.contains(key.rawValue) {
                missingFunctionError = OWMError.missingFunction(
                    function: key.functionName,
                    method: "\(method)",
                    underlyingError: missingFunctionError
                )
            }
        }
    }
    
    private func check<T: Decodable>(_ type: T.Type) -> Error? {
        var result: Error?
        let invalidTypeError = OWMError.invalidType(type: String(describing: type), method: "\(method)")
        switch method {
        case .currentWeather:
            if type != CurrentWeather.self {
                result = invalidTypeError
            }
        case .currentWeatherByRectangle, .currentWeatherByCircle:
            if type != CurrentWeatherList.self {
                result = invalidTypeError
            }
        case .oneCall:
            if type != OneCall.self {
                result = invalidTypeError
            }
        case .direct,
             .reverse:
            if type != [Geocoding].self {
                result = invalidTypeError
            }
        }
        return result
    }
    
    private func buildUrl() -> URL? {
        parameters[Key.appid.rawValue] = OpenWeatherMapSDK.apiKey
        let parametersString = parameters.map { $0 + "=" + ($1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $1) }.joined(separator: "&")
        let urlString = Constants.baseUrl + method.api + method.rawValue + "?" + parametersString
        #if DEBUG
        print("URL string: \(urlString)")
        #endif
        return URL(string: urlString)
    }
}
