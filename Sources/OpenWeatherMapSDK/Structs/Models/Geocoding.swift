
import Foundation

public struct Geocoding: Decodable, CustomStringConvertible {
    
    private enum GeocodingCodingKey: String, CodingKey {
        
        case name       = "name"
        case localNames = "local_names"
        case lat        = "lat"
        case lon        = "lon"
        case country    = "country"
        case state      = "state"
    }
    
    public var name:       String
    public var localNames: [String: String]
    public var lat:        Float
    public var lon:        Float
    public var country:    String
    public var state:      String
    
    public var description: String {
        return "(name: \(name), local names: \(localNames), lat: \(lat), lon: \(lon), country: \(country), state: \(state))"
    }
    
    public init() {
        self.name       = .init()
        self.localNames = .init()
        self.lat        = 0.0
        self.lon        = 0.0
        self.country    = .init()
        self.state      = .init()
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GeocodingCodingKey.self)
        self.name       = (try? container.decode(String.self,           forKey: .name))       ?? .init()
        self.localNames = (try? container.decode([String: String].self, forKey: .localNames)) ?? .init()
        self.lat        = (try? container.decode(Float.self,            forKey: .lat))        ?? 0.0
        self.lon        = (try? container.decode(Float.self,            forKey: .lon))        ?? 0.0
        self.country    = (try? container.decode(String.self,           forKey: .country))    ?? .init()
        self.state      = (try? container.decode(String.self,           forKey: .state))      ?? .init()
    }
}
