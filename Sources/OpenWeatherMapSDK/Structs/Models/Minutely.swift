
import Foundation

public struct Minutely: Decodable, CustomStringConvertible {
    
    private enum MinutelyCodingKey: String, CodingKey {
        
        case date          = "dt"
        case precipitation = "Precipitation"
    }
    
    public var date:          Int
    public var precipitation: Int
    
    public var description: String {
        return "(date: \(date), precipitation: \(precipitation))"
    }
    
    init() {
        self.date          = 0
        self.precipitation = 0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MinutelyCodingKey.self)
        
        self.date          = (try? container.decode(Int.self, forKey: .date))          ?? 0
        self.precipitation = (try? container.decode(Int.self, forKey: .precipitation)) ?? 0
    }
}
