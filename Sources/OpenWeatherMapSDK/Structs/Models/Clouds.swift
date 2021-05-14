
import Foundation

public struct Clouds: Decodable, CustomStringConvertible {
    
    private enum CloudsCodingKey: String, CodingKey {
        
        case all = "all"
    }
    
    public var all: Float
    
    public var description: String {
        return "(all: \(all))"
    }
    
    internal init() {
        self.all = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CloudsCodingKey.self)
        
        self.all = (try? container.decode(Float.self, forKey: .all)) ?? 0.0
    }
}
