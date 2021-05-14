
import Foundation

struct JSONError: Decodable, CustomStringConvertible {
    
    private enum JSONErrorCodingKey: String, CodingKey {
        
        case code    = "cod"
        case message = "message"
    }
    
    var code: String
    var message: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONErrorCodingKey.self)
        
        self.code    = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
    }
    
    var description: String {
        return "(code: \(code), message: \(message))"
    }
}
