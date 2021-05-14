
import Foundation

public struct Hours: Decodable, CustomStringConvertible {
    
    private enum HoursCodingKey: String, CodingKey {
        
        case h1 = "1h"
        case h3 = "3h"
    }
    
    public var h1: Float
    public var h3: Float
    
    public var description: String {
        return "(1: \(h1), 3: \(h3))"
    }
    
    internal init() {
        self.h1 = 0.0
        self.h3 = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HoursCodingKey.self)
        
        self.h1 = (try? container.decode(Float.self, forKey: .h1)) ?? 0.0
        self.h3 = (try? container.decode(Float.self, forKey: .h3)) ?? 0.0
    }
}
