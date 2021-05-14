
import Foundation

public struct CurrentWeather: Decodable, CustomStringConvertible {
    
    private enum CurrentWeatherCodingKey: String, CodingKey {
        
        case coordinates = "coord"
        case weather     = "weather"
        case main        = "main"
        case wind        = "wind"
        case clouds      = "clouds"
        case rain        = "rain"
        case snow        = "snow"
        case date        = "dt"
        case system      = "sys"
        case timezone    = "timezone"
        case cityId      = "id"
        case cityName    = "name"
    }
    
    public var coordinates: Coordinates
    
    public var weather: [Weather]
    
    public var main: CurrentMain
    
    public var clouds: Clouds
    
    public var rain: Hours
    public var snow: Hours
    
    public var date: Int
    
    public var system: System
    
    public var timezone: Int
    
    public var cityId: String
    public var cityName: String
    
    public var description: String {
        return "(coordinates: \(coordinates), weather: \(weather), main: \(main), clouds: \(clouds), rain: \(rain), show: \(snow), date: \(date), system: \(system), timezone: \(timezone), cityId: \(cityId), cityName: \(cityName))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentWeatherCodingKey.self)
        
        self.coordinates = (try? container.decode(Coordinates.self, forKey: .coordinates)) ?? .init()
        self.weather     = (try? container.decode([Weather].self,   forKey: .weather))     ?? []
        self.main        = (try? container.decode(CurrentMain.self, forKey: .main))        ?? .init()
        self.clouds      = (try? container.decode(Clouds.self,      forKey: .clouds))      ?? .init()
        self.rain        = (try? container.decode(Hours.self,       forKey: .rain))        ?? .init()
        self.snow        = (try? container.decode(Hours.self,       forKey: .snow))        ?? .init()
        self.date        = (try? container.decode(Int.self,         forKey: .date))        ?? 0
        self.system      = (try? container.decode(System.self,      forKey: .system))      ?? .init()
        self.timezone    = (try? container.decode(Int.self,         forKey: .timezone))    ?? 0
        self.cityId      = (try? container.decode(String.self,      forKey: .cityId))      ?? ""
        self.cityName    = (try? container.decode(String.self,      forKey: .cityName))    ?? ""
    }
}
