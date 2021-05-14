
import Foundation
import Alamofire

public enum Method: String, CustomStringConvertible {
    
    case currentWeather            = "/weather"
    case currentWeatherByRectangle = "/box/city"
    case currentWeatherByCircle    = "/find"
    
    public var description: String {
        switch self {
        case .currentWeather:
            return "currentWeather"
        case .currentWeatherByRectangle:
            return "currentWeatherByRectangle"
        case .currentWeatherByCircle:
            return "currentWeatherByCircle"
        }
    }
}

public enum Units: String {
    
    case standard = "standard"
    case imperial = "imperial"
    case metric   = "metric"
}

public enum Language: String {
    
    case afrikaans          = "af"
    case albanian           = "al"
    case arabic             = "ar"
    case azerbaijani        = "az"
    case bulgarian          = "bg"
    case catalan            = "ca"
    case czech              = "cz"
    case danish             = "da"
    case german             = "de"
    case greek              = "el"
    case english            = "en"
    case basque             = "eu"
    case persian            = "fa"
    case finnish            = "fi"
    case french             = "fr"
    case galician           = "gl"
    case hebrew             = "he"
    case hindi              = "hi"
    case croatian           = "hr"
    case hungarian          = "hu"
    case indonesian         = "id"
    case italian            = "it"
    case japanese           = "ja"
    case korean             = "kr"
    case latvian            = "la"
    case lithuanian         = "lt"
    case macedonian         = "mk"
    case norwegian          = "no"
    case dutch              = "nl"
    case polish             = "pl"
    case portuguese         = "pt"
    case portuguesBrasil    = "pt_br"
    case romanian           = "ro"
    case russian            = "ru"
    case swedish            = "sv"
    case slovak             = "sk"
    case slovenian          = "sl"
    case spanish            = "sp"
    case serbian            = "sr"
    case thai               = "th"
    case turkish            = "tr"
    case ukrainian          = "ua"
    case vietnamese         = "vi"
    case chineseSimplified  = "zh_cn"
    case chineseTraditional = "zh_tw"
    case zulu               = "zu"
}

struct Constants {
    
    static let baseUrl = "https://api.openweathermap.org/data/2.5"
}

public class OpenWeatherMapSDK {
    
    static public var apiKey = ""
}

public class RequestBuilder {
    
    internal var method: Method
    
    internal var parameters: [String: String]
    
    internal var invalidFunctionError: Error?
    internal var missingFunctionError: Error?
    
    public init(_ method: Method) {
        self.method = method
        self.parameters = [String: String]()
    }
    
    @discardableResult
    public func units(_ units: Units) -> Self {
        switch units {
        case .standard:
            break
        default:
            parameters[Keys.units.rawValue] = units.rawValue
        }
        return self
    }
    
    @discardableResult
    public func language(_ language: Language) -> Self {
        parameters[Keys.lang.rawValue] = language.rawValue
        return self
    }
    
    @discardableResult
    public func city(name: String, stateCode: String? = nil, countryCode: String? = nil) -> Self {
        let result = [name, stateCode, countryCode].compactMap { $0 }.joined(separator: ",")
        parameters[Keys.q.rawValue] = result
        return self
    }
    
    @discardableResult
    public func id(_ id: String) -> Self {
        parameters[Keys.id.rawValue] = id
        return self
    }
    
    @discardableResult
    public func coordinates(lat: Float, lon: Float) -> Self {
        parameters[Keys.lat.rawValue] = String(lat)
        parameters[Keys.lon.rawValue] = String(lon)
        return self
    }
    
    @discardableResult
    public func zip(_ zip: String) -> Self {
        parameters[Keys.zip.rawValue] = zip
        return self
    }
    
    @discardableResult
    public func rectangle(lonLeft: Float, latBottom: Float, lonRight: Float, latTop: Float, zoom: Int = 10) -> Self {
        parameters[Keys.bbox.rawValue] = "\(lonLeft),\(latBottom),\(lonRight),\(latTop),\(zoom)"
        return self
    }
    
    @discardableResult
    public func circle(_ number: Int) -> Self {
        let cnt = number <= 0 ? 1 : (number > 50 ? 50 : number)
        parameters[Keys.cnt.rawValue] = String(cnt)
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
        return AF.request(url).validate().responseDecodable(of: type, queue: .main) { response in
            if let error = response.error {
                block(.failure(error))
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
    
    private func buildUrl() -> URL? {
        parameters[Keys.appid.rawValue] = OpenWeatherMapSDK.apiKey
        let parametersString = parameters.map { $0 + "=" + $1 }.joined(separator: "&")
        let urlString = Constants.baseUrl + method.rawValue + "?" + parametersString
        return URL(string: urlString)
    }
    
    private func checkInvalidFunctions() {
        let set = Set(parameters.keys)
        var keys: [Keys]
        switch method {
        case .currentWeather:
            keys = [
                .bbox,
                .cnt
            ]
        case .currentWeatherByRectangle:
            keys = [
                .q,
                .id,
                .lat,
                .zip,
                .cnt,
            ]
        case .currentWeatherByCircle:
            keys = [
                .q,
                .id,
                .lat,
                .zip,
                .bbox,
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
        var keys: [Keys] = []
        switch method {
        case .currentWeather:
            let isValid =
                set.contains(Keys.q.rawValue)   ||
                set.contains(Keys.id.rawValue)  ||
                set.contains(Keys.lat.rawValue) ||
                set.contains(Keys.zip.rawValue)
            if !isValid {
                missingFunctionError = OWMError.missingFunction(
                    function: Keys.q.functionName,
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
        }
        for key in keys {
            if !set.contains(key.rawValue) {
                invalidFunctionError = OWMError.invalidFunction(
                    function: key.functionName,
                    method: "\(method)",
                    underlyingError: invalidFunctionError
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
        case .currentWeatherByRectangle:
            if type != CurrentWeatherByRectangle.self {
                result = invalidTypeError
            }
        case .currentWeatherByCircle:
            if type != CurrentWeatherByCircle.self {
                result = invalidTypeError
            }
        }
        return result
    }
}

public enum OWMError: CustomNSError, LocalizedError {
    
    case urlIsWrong
    case valueIsNil
    case invalidFunction(function: String, method: String, underlyingError: Error?)
    case invalidType(type: String, method: String)
    case missingFunction(function: String, method: String, underlyingError: Error?)
    
    public static var errorDomain: String {
        return "OpenWeatherMapErrorDomain"
    }
    
    public var errorCode: Int {
        switch self {
        case .urlIsWrong:
            return -100
        case .valueIsNil:
            return -101
        case .invalidFunction:
            return -300
        case .invalidType:
            return -301
        case .missingFunction:
            return -302
        }
    }
    
    public var errorUserInfo: [String : Any] {
        var result = [String: Any]()
        var resultUnderlyingError: Error?
        switch self {
        case .invalidFunction(_, _, let underlyingError):
            resultUnderlyingError = underlyingError
        case .missingFunction(_, _, let underlyingError):
            resultUnderlyingError = underlyingError
        default:
            break
        }
        result[NSUnderlyingErrorKey] = resultUnderlyingError
        return result
    }
    
    public var errorDescription: String? {
        switch self {
        case .urlIsWrong:
            return "URL is wrong"
        case .valueIsNil:
            return "Value is nil"
        case .invalidFunction(let function, let method, _):
            return "Invalid function '\(function)' for '\(method)' method"
        case .invalidType(let type, let method):
            return "Invalid type '\(type)' for '\(method)' method"
        case .missingFunction(let function, let method, _):
            return "Missing function '\(function)' for '\(method)' method"
        }
    }
}

internal enum Keys: String {
    
    case units = "units"
    case lang  = "lang"
    case q     = "q"
    case id    = "id"
    case lat   = "lat"
    case lon   = "lon"
    case zip   = "zip"
    case bbox  = "bbox"
    case cnt   = "cnt"
    case appid = "appid"
    
    var functionName: String {
        switch self {
        case .q:
            return "city(name:stateCode:countryCode:)"
        case .id:
            return "id(_:)"
        case .lat, .lon:
            return "coordinates(lat:lon:)"
        case .zip:
            return "zip(_:)"
        case .bbox:
            return "rectangle(lonLeft:latBottom:lonRight:latTop:zoom:)"
        case .cnt:
            return "circle(_:)"
        default:
            return ""
        }
    }
}
