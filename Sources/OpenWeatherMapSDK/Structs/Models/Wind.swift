
import Foundation

public struct Wind: Decodable, CustomStringConvertible {
    
    private enum WindCodingKey: String, CodingKey {
        
        case speed   = "speed"
        case degrees = "deg"
        case gust    = "gust"
    }
    
    public var speed:   Float
    public var degrees: Float
    public var gust:    Float
    
    public var description: String {
        return "(speed: \(speed), degrees: \(degrees), gust: \(gust))"
    }
    
    internal init() {
        self.speed   = 0.0
        self.degrees = 0.0
        self.gust    = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WindCodingKey.self)
        
        self.speed   = (try? container.decode(Float.self, forKey: .speed))   ?? 0.0
        self.degrees = (try? container.decode(Float.self, forKey: .degrees)) ?? 0.0
        self.gust    = (try? container.decode(Float.self, forKey: .gust))    ?? 0.0
    }
}
