
import Foundation

public enum ResponseFormat: String {
    
    case json = ""
    case xml = "xml"
    case html = "html"
}

struct Constants {
    
    static let baseUrl = "https://api.openweathermap.org/data/2.5"
}

public class OpenWeatherMapSDK {
    
    static public var apiKey = ""
}

public class Builder {
    
    internal var parameters: [String]
    
    public init() {
        self.parameters = [String]()
    }
    
    internal func method() -> String {
        return ""
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
    
    public func build() -> URL {
        parameters.append("appid=" + OpenWeatherMapSDK.apiKey)
        let parametersString = parameters.joined(separator: "&")
        let urlString = Constants.baseUrl + "?" + parametersString
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        return url
    }
}

public class CurrentWeatherDataBuilder: Builder {
    
    override func method() -> String {
        return "/weather"
    }
    
    public func city(name: String, stateCode: String? = nil, countryCode: String? = nil) -> Self {
        let result = [name, stateCode, countryCode].compactMap { $0 }.joined(separator: ",")
        parameters.append("q=" + result)
        return self
    }
}
