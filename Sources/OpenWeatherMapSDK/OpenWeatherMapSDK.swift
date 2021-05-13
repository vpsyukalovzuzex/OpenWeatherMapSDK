
import Foundation
import Alamofire

public enum Method: String {
    
    case currentWeather            = "/weather"
    case currentWeatherByRectangle = "/box/city"
    case currentWeatherByCircle    = "/find"
}

public enum Units: String {
    
    case standard = "standard"
    case imperial = "imperial"
    case metric   = "metric"
}

public enum Language: String {
    
    case afrikaans = "af"
    case albanian = "al"
    case arabic = "ar"
    case azerbaijani = "az"
    case bulgarian = "bg"
    case catalan = "ca"
    case czech = "cz"
    case danish = "da"
    case german = "de"
    case greek = "el"
    case english = "en"
    case basque = "eu"
    case persian = "fa"
    case finnish = "fi"
    case french = "fr"
    case galician = "gl"
    case hebrew = "he"
    case hindi = "hi"
    case croatian = "hr"
    case hungarian = "hu"
    case indonesian = "id"
    case italian = "it"
    case japanese = "ja"
    case korean = "kr"
    case latvian = "la"
    case lithuanian = "lt"
    case macedonian = "mk"
    case norwegian = "no"
    case dutch = "nl"
    case polish = "pl"
    case portuguese = "pt"
    case portuguesBrasil = "pt_br"
    case romanian = "ro"
    case russian = "ru"
    case swedish = "sv"
    case slovak = "sk"
    case slovenian = "sl"
    case spanish = "sp"
    case serbian = "sr"
    case thai = "th"
    case turkish = "tr"
    case ukrainian = "ua"
    case vietnamese = "vi"
    case chineseSimplified  = "zh_cn"
    case chineseTraditional = "zh_tw"
    case zulu = "zu"
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
    
    public init(_ method: Method) {
        self.method = method
        self.parameters = [String: String]()
    }
    
    public func units(_ units: Units) -> Self {
        switch units {
        case .standard:
            break
        default:
            parameters["units"] = units.rawValue
        }
        return self
    }
    
    public func language(_ language: Language) -> Self {
        parameters["lang"] = language.rawValue
        return self
    }
    
    public func city(name: String, stateCode: String? = nil, countryCode: String? = nil) -> Self {
        let result = [name, stateCode, countryCode].compactMap { $0 }.joined(separator: ",")
        parameters["q"] = result
        return self
    }
    
    public func id(_ id: String) -> Self {
        parameters["id"] = id
        return self
    }
    
    public func coordinates(lat: Float, lon: Float) -> Self {
        parameters["lat"] = String(lat)
        parameters["lon"] = String(lon)
        return self
    }
    
    public func zip(_ zip: String) -> Self {
        parameters["zip"] = zip
        return self
    }
    
    public func rectangle(lonLeft: Float, latBottom: Float, lonRight: Float, latTop: Float, zoom: Float = 10.0) -> Self {
        guard method == .currentWeatherByRectangle else {
            fatalError("Invalid type for this function")
        }
        parameters["bbox"] = "\(lonLeft),\(latBottom),\(lonRight),\(latTop),\(zoom)"
        return self
    }
    
    public func circle(_ number: Int) -> Self {
        guard method == .currentWeatherByCircle else {
            fatalError("Invalid type for this function")
        }
        let cnt = number <= 0 ? 1 : (number > 50 ? 50 : number)
        parameters["cnt"] = String(cnt)
        return self
    }
    
    @discardableResult
    public func request<T: Decodable>(_ type: T.Type, _ block: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        guard let url = buildUrl() else {
            block(.failure(OWMError.urlIsWrong))
            return nil
        }
        print(url.absoluteURL)
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
}

enum OWMError: CustomNSError, LocalizedError {
    
    case urlIsWrong, valueIsNil
    
    static var errorDomain: String {
        return "OpenWeatherMapErrorDomain"
    }
    
    var errorCode: Int {
        switch self {
        case .urlIsWrong:
            return -100
        case .valueIsNil:
            return -101
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .urlIsWrong:
            return "URL is wrong"
        case .valueIsNil:
            return "Response data is nil"
        }
    }
}
