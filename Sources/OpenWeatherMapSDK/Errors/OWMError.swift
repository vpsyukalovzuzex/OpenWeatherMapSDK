
import Foundation

public enum OWMError: CustomNSError, LocalizedError {
    
    case urlIsWrong
    case valueIsNil
    case invalidFunction(function: String, method: String, underlyingError: Error?)
    case invalidType(type: String, method: String)
    case missingFunction(function: String, method: String, underlyingError: Error?)
    case badResponce(code: Int, message: String)
    
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
        case .badResponce(let code, _):
            return code
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
        case .badResponce(_, let message):
            return message
        }
    }
}
