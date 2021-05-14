
import Foundation

public struct Weather: Decodable, CustomStringConvertible {
    
    private enum WeatherCodingKey: String, CodingKey {
        
        case id       = "id"
        case main     = "main"
        case text     = "description"
        case iconName = "icon"
    }
    
    public var id: Int
    
    public var main:     String
    public var text:     String
    public var iconName: String
    
    public var description: String {
        return "(id: \(id), main: \(main), description: \(text), icon name: \(iconName))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherCodingKey.self)
        
        self.id       = (try? container.decode(Int.self,    forKey: .id))       ?? 0
        self.main     = (try? container.decode(String.self, forKey: .main))     ?? ""
        self.text     = (try? container.decode(String.self, forKey: .text))     ?? ""
        self.iconName = (try? container.decode(String.self, forKey: .iconName)) ?? ""
    }
}
