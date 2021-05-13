
import Foundation
import Alamofire

public enum ResponseFormat: String {
    
    case json = ""
    case xml = "xml"
    case html = "html"
}

public enum Method: String {
    
    case undefined = ""
    case weather = "/weather"
    case rectangle = "/box/city"
    case circle = "/find"
}

public enum Units: String {
    
    case standard = "standard"
    case imperial = "imperial"
    case metric = "metric"
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
    case chineseSimplified = "zh_cn"
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
    
    internal var method: Method {
        willSet {
            if method != .undefined {
                fatalError("Invalid request builder funcion set")
            }
        }
    }
    
    internal var parameters: [String]
    
    public init() {
        self.method = .undefined
        self.parameters = [String]()
    }
    
    public func responseFormat(_ responseFormat: ResponseFormat) -> Self {
        switch responseFormat {
        case .json:
            break
        default:
            parameters.append("mode=" + responseFormat.rawValue)
        }
        return self
    }
    
    public func units(_ units: Units) -> Self {
        switch units {
        case .standard:
            break
        default:
            parameters.append("units=" + units.rawValue)
        }
        return self
    }
    
    public func language(_ language: Language) -> Self {
        parameters.append("lang=" + language.rawValue)
        return self
    }
    
    public func city(name: String, stateCode: String? = nil, countryCode: String? = nil) -> Self {
        method = .weather
        let result = [name, stateCode, countryCode].compactMap { $0 }.joined(separator: ",")
        parameters.append("q=" + result)
        return self
    }
    
    public func id(_ id: String) -> Self {
        method = .weather
        parameters.append("id=" + id)
        return self
    }
    
    public func coordinates(lat: Float, lon: Float) -> Self {
        method = .weather
        parameters.append("lat=\(lat)")
        parameters.append("lon=\(lon)")
        return self
    }
    
    public func zip(_ zip: String) -> Self {
        method = .weather
        parameters.append("zip=" + zip)
        return self
    }
    
    public func rectangle(lonLeft: Float, latBottom: Float, lonRight: Float, latTop: Float, zoom: Float = 10.0) -> Self {
        method = .rectangle
        parameters.append("bbox=\(lonLeft),\(latBottom),\(lonRight),\(latTop),\(zoom)")
        return self
    }
    
    public func circle(_ number: Int) -> Self {
        method = .circle
        let cnt = number <= 0 ? 1 : (number > 50 ? 50 : number)
        parameters.append("cnt=\(cnt)")
        return self
    }
    
    @discardableResult
    public func request(_ block: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask? {
        guard let url = buildUrl() else {
            block(.failure(OWMError.urlIsWrong))
            return nil
        }
        return AF.request(url, method: .get).response(queue: .main) { response in
            if let error = response.error {
                block(.failure(error))
                return
            }
            if let data = response.data {
                block(.success(data))
                return
            }
            block(.failure(OWMError.responseDataIsNil))
        }.task
    }
    
    private func buildUrl() -> URL? {
        if method == .undefined {
            return nil
        }
        parameters.append("appid=" + OpenWeatherMapSDK.apiKey)
        let parametersString = parameters.joined(separator: "&")
        let urlString = Constants.baseUrl + method.rawValue + "?" + parametersString
        return URL(string: urlString)
    }
}

enum OWMError: CustomNSError, LocalizedError {
    
    case urlIsWrong, responseDataIsNil
    
    static var errorDomain: String {
        return "OpenWeatherMapErrorDomain"
    }
    
    var errorCode: Int {
        switch self {
        case .urlIsWrong:
            return -100
        case .responseDataIsNil:
            return -101
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .urlIsWrong:
            return "URL is wrong"
        case .responseDataIsNil:
            return "Response data is nil"
        }
    }
}
