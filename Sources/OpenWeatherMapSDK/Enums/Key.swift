
import Foundation

internal enum Key: String {
    
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
