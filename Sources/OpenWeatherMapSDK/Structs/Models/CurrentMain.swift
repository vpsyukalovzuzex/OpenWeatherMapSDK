
import Foundation

public struct CurrentMain: Decodable, CustomStringConvertible {
    
    private enum CurrentMainCodingKey: String, CodingKey {
        
        case temp           = "temp"
        case feelsLike      = "feels_like"
        case pressure       = "pressure"
        case humidity       = "humidity"
        case tempMin        = "temp_min"
        case tempMax        = "temp_max"
        case seaPressure    = "sea_level"
        case groundPressure = "grnd_level"
    }
    
    public var temp:           Float
    public var feelsLike:      Float
    public var pressure:       Float
    public var humidity:       Float
    public var tempMin:        Float
    public var tempMax:        Float
    public var seaPressure:    Float
    public var groundPressure: Float
    
    public var description: String {
        return "(temperature: \(temp) (min: \(tempMin), max: \(tempMax)), feels like: \(feelsLike), pressure: \(pressure) (sea: \(seaPressure), ground: \(groundPressure)), humidity: \(humidity)"
    }
    
    internal init() {
        self.temp           = 0.0
        self.feelsLike      = 0.0
        self.pressure       = 0.0
        self.humidity       = 0.0
        self.tempMin        = 0.0
        self.tempMax        = 0.0
        self.seaPressure    = 0.0
        self.groundPressure = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentMainCodingKey.self)
        
        self.temp           = (try? container.decode(Float.self, forKey: .temp))           ?? 0.0
        self.feelsLike      = (try? container.decode(Float.self, forKey: .feelsLike))      ?? 0.0
        self.pressure       = (try? container.decode(Float.self, forKey: .pressure))       ?? 0.0
        self.humidity       = (try? container.decode(Float.self, forKey: .humidity))       ?? 0.0
        self.tempMin        = (try? container.decode(Float.self, forKey: .tempMin))        ?? 0.0
        self.tempMax        = (try? container.decode(Float.self, forKey: .tempMax))        ?? 0.0
        self.seaPressure    = (try? container.decode(Float.self, forKey: .seaPressure))    ?? 0.0
        self.groundPressure = (try? container.decode(Float.self, forKey: .groundPressure)) ?? 0.0
    }
}
