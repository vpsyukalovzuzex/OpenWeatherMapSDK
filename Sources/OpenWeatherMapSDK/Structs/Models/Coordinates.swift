
import Foundation

public struct Coordinates: Decodable, CustomStringConvertible {
    
    private enum CoordinatesCodingKey: String, CodingKey {
        
        case latitude  = "lat"
        case longitude = "lon"
    }
    
    public var latitude: Float
    public var longitude: Float
    
    public var description: String {
        return "(latitude: \(latitude), longitude: \(longitude))"
    }
    
    internal init() {
        self.latitude  = 0.0
        self.longitude = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoordinatesCodingKey.self)
        
        self.latitude  = (try? container.decode(Float.self, forKey: .latitude))  ?? 0.0
        self.longitude = (try? container.decode(Float.self, forKey: .longitude)) ?? 0.0
    }
}
