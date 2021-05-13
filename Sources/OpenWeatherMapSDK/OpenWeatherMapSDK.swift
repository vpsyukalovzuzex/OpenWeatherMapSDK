
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
    
    internal var error: Error?
    
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
            parameters["units"] = units.rawValue
        }
        return self
    }
    
    @discardableResult
    public func language(_ language: Language) -> Self {
        parameters["lang"] = language.rawValue
        return self
    }
    
    @discardableResult
    public func city(name: String, stateCode: String? = nil, countryCode: String? = nil) -> Self {
        check(#function)
        let result = [name, stateCode, countryCode].compactMap { $0 }.joined(separator: ",")
        parameters["q"] = result
        return self
    }
    
    @discardableResult
    public func id(_ id: String) -> Self {
        check(#function)
        parameters["id"] = id
        return self
    }
    
    @discardableResult
    public func coordinates(lat: Float, lon: Float) -> Self {
        check(#function)
        parameters["lat"] = String(lat)
        parameters["lon"] = String(lon)
        return self
    }
    
    @discardableResult
    public func zip(_ zip: String) -> Self {
        check(#function)
        parameters["zip"] = zip
        return self
    }
    
    @discardableResult
    public func rectangle(lonLeft: Float, latBottom: Float, lonRight: Float, latTop: Float, zoom: Float = 10.0) -> Self {
        if method != .currentWeatherByRectangle {
            error = OWMError.invalid(function: #function, method: "\(method)", underlyingError: error)
        }
        parameters["bbox"] = "\(lonLeft),\(latBottom),\(lonRight),\(latTop),\(zoom)"
        return self
    }
    
    @discardableResult
    public func circle(_ number: Int) -> Self {
        if method != .currentWeatherByCircle {
            error = OWMError.invalid(function: #function, method: "\(method)", underlyingError: error)
        }
        let cnt = number <= 0 ? 1 : (number > 50 ? 50 : number)
        parameters["cnt"] = String(cnt)
        return self
    }
    
    @discardableResult
    public func request<T: Decodable>(_ type: T.Type, _ block: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        if let error = error {
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
    
    private func buildUrl() -> URL? {
        parameters["appid"] = OpenWeatherMapSDK.apiKey
        let parametersString = parameters.map { $0 + "=" + $1 }.joined(separator: "&")
        let urlString = Constants.baseUrl + method.rawValue + "?" + parametersString
        return URL(string: urlString)
    }
    
    private func check(_ function: String) {
        let methods: [Method] = [
            .currentWeatherByRectangle,
            .currentWeatherByCircle
        ]
        if methods.contains(method) {
            error = OWMError.invalid(function: function, method: "\(method)", underlyingError: error)
        }
    }
}

enum OWMError: CustomNSError, LocalizedError {
    
    case urlIsWrong, valueIsNil, invalid(function: String, method: String, underlyingError: Error?)
    
    static var errorDomain: String {
        return "OpenWeatherMapErrorDomain"
    }
    
    var errorCode: Int {
        switch self {
        case .urlIsWrong:
            return -100
        case .valueIsNil:
            return -101
        case .invalid:
            return -300
        }
    }
    
    var errorUserInfo: [String : Any] {
        var result = [String: Any]()
        switch self {
        case .invalid(_, _, let underlyingError):
            result[NSUnderlyingErrorKey] = underlyingError
        default:
            break
        }
        return result
    }
    
    var errorDescription: String? {
        switch self {
        case .urlIsWrong:
            return "URL is wrong"
        case .valueIsNil:
            return "Value is nil"
        case .invalid(let function, let method, _):
            return "Invalid function '\(function)' for '\(method)' method"
        }
    }
}
