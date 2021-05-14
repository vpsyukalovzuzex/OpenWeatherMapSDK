
import Foundation

public struct CurrentWeatherList: Decodable, CustomStringConvertible {
    
    private enum CurrentWeatherListCodingKey: String, CodingKey {
        
        case list = "list"
    }
    
    public var list: [CurrentWeather]
    
    public var description: String {
        return "\(list)"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentWeatherListCodingKey.self)
        
        self.list = (try? container.decode([CurrentWeather].self, forKey: .list)) ?? []
    }
}
