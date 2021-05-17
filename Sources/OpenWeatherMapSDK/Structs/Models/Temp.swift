
import Foundation

public struct Temp: Decodable, CustomStringConvertible {
    
    private enum TempCodingKey: String, CodingKey {
        
        case morning = "morn"
        case day     = "day"
        case evening = "eve"
        case night   = "night"
        case min     = "min"
        case max     = "max"
    }
    
    public var morning: Float
    public var day:     Float
    public var evening: Float
    public var night:   Float
    public var min:     Float
    public var max:     Float
    
    public var description: String {
        return "(morning: \(morning), day: \(day), evening: \(evening), night: \(night), min: \(min), max: \(max))"
    }
    
    public init() {
        self.morning = 0.0
        self.day     = 0.0
        self.evening = 0.0
        self.night   = 0.0
        self.min     = 0.0
        self.max     = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TempCodingKey.self)
        
        self.morning = (try? container.decode(Float.self, forKey: .morning)) ?? 0.0
        self.day     = (try? container.decode(Float.self, forKey: .day))     ?? 0.0
        self.evening = (try? container.decode(Float.self, forKey: .evening)) ?? 0.0
        self.night   = (try? container.decode(Float.self, forKey: .night))   ?? 0.0
        self.min     = (try? container.decode(Float.self, forKey: .min))     ?? 0.0
        self.max     = (try? container.decode(Float.self, forKey: .max))     ?? 0.0
    }
}
