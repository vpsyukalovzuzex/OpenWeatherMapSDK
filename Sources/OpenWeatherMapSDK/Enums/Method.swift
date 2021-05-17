
import Foundation

public enum Method: String, CustomStringConvertible {
    
    case currentWeather            = "/weather"
    case currentWeatherByRectangle = "/box/city"
    case currentWeatherByCircle    = "/find"
    case oneCall                   = "/onecall"
    case direct                    = "/direct"
    case reverse                   = "/reverse"
    
    public var api: String {
        switch self {
        case .currentWeather,
             .currentWeatherByCircle,
             .currentWeatherByRectangle,
             .oneCall:
            return Constants.data
        case .direct,
             .reverse:
            return Constants.geo
        }
    }
    
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
        case .direct:
            return "direct"
        case .reverse:
            return "reverse"
        }
    }
}
