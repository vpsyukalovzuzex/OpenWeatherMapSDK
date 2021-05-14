
import Foundation

public enum Method: String, CustomStringConvertible {
    
    case currentWeather            = "/weather"
    case currentWeatherByRectangle = "/box/city"
    case currentWeatherByCircle    = "/find"
    case oneCall                   = "/onecall"
    
    public var description: String {
        switch self {
        case .currentWeather:
            return "currentWeather"
        case .currentWeatherByRectangle:
            return "currentWeatherByRectangle"
        case .currentWeatherByCircle:
            return "currentWeatherByCircle"
        case .oneCall:
            return "oneCall"
        }
    }
}
