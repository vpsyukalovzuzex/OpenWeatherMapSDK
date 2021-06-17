
import Foundation

public struct Daily: Decodable, CustomStringConvertible {
    
    private enum DailyCodingKey: String, CodingKey {
        
        case date        = "dt"
        case sunrise     = "sunrise"
        case sunset      = "sunset"
        case moonrise    = "moonrise"
        case moonset     = "moonset"
        case moonPhase   = "moon_phase"
        case temp        = "temp"
        case feelsLike   = "feels_like"
        case pressure    = "pressure"
        case humidity    = "humidity"
        case dewPoint    = "dew_point"
        case windSpeed   = "wind_speed"
        case windGust    = "wind_gust"
        case windDegrees = "wind_deg"
        case clouds      = "clouds"
        case uvi         = "uvi"
        case pop         = "pop"
        case rain        = "rain"
        case snow        = "snow"
        case weather     = "weather"
    }
    
    public var date:        Int
    public var sunrise:     Int
    public var sunset:      Int
    public var moonrise:    Int
    public var moonset:     Int
    public var moonPhase:   Float
    public var temp:        Temp
    public var feelsLike:   Temp
    public var pressure:    Float
    public var humidity:    Float
    public var dewPoint:    Float
    public var windSpeed:   Float
    public var windGust:    Float
    public var windDegrees: Float
    public var clouds:      Float
    public var uvi:         Float
    public var pop:         Float
    public var rain:        Float
    public var snow:        Float
    public var weather:     [Weather]
    
    public var description: String {
        return "(date: \(date), sunrise: \(sunrise), sunset: \(sunset), moonrise: \(moonrise), moonseet: \(moonset), moon phase: \(moonPhase), temp: \(temp), feels like: \(feelsLike), pressure: \(pressure), humidity: \(humidity), dew point: \(dewPoint), wind speed: \(windSpeed), wind gust: \(windGust), wind degrees: \(windDegrees), clouds: \(clouds), uvi: \(uvi), probability of precipitation: \(pop), rain: \(rain), snow: \(snow), weather: \(weather))"
    }
    
    public init() {
        self.date        = 0
        self.sunrise     = 0
        self.sunset      = 0
        self.moonrise    = 0
        self.moonset     = 0
        self.moonPhase   = 0.0
        self.temp        = .init()
        self.feelsLike   = .init()
        self.pressure    = 0.0
        self.humidity    = 0.0
        self.dewPoint    = 0.0
        self.windSpeed   = 0.0
        self.windGust    = 0.0
        self.windDegrees = 0.0
        self.clouds      = 0.0
        self.uvi         = 0.0
        self.pop         = 0.0
        self.rain        = 0.0
        self.snow        = 0.0
        self.weather     = .init()
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DailyCodingKey.self)
        
        self.date        = (try? container.decode(Int.self,       forKey: .date))        ?? 0
        self.sunrise     = (try? container.decode(Int.self,       forKey: .sunrise))     ?? 0
        self.sunset      = (try? container.decode(Int.self,       forKey: .sunset))      ?? 0
        self.moonrise    = (try? container.decode(Int.self,       forKey: .moonrise))    ?? 0
        self.moonset     = (try? container.decode(Int.self,       forKey: .moonset))     ?? 0
        self.moonPhase   = (try? container.decode(Float.self,     forKey: .moonPhase))   ?? 0.0
        self.temp        = (try? container.decode(Temp.self,      forKey: .temp))        ?? .init()
        self.feelsLike   = (try? container.decode(Temp.self,      forKey: .feelsLike))   ?? .init()
        self.pressure    = (try? container.decode(Float.self,     forKey: .pressure))    ?? 0.0
        self.humidity    = (try? container.decode(Float.self,     forKey: .humidity))    ?? 0.0
        self.dewPoint    = (try? container.decode(Float.self,     forKey: .dewPoint))    ?? 0.0
        self.windSpeed   = (try? container.decode(Float.self,     forKey: .windSpeed))   ?? 0.0
        self.windGust    = (try? container.decode(Float.self,     forKey: .windGust))    ?? 0.0
        self.windDegrees = (try? container.decode(Float.self,     forKey: .windDegrees)) ?? 0.0
        self.clouds      = (try? container.decode(Float.self,     forKey: .clouds))      ?? 0.0
        self.uvi         = (try? container.decode(Float.self,     forKey: .uvi))         ?? 0.0
        self.pop         = (try? container.decode(Float.self,     forKey: .pop))         ?? 0.0
        self.rain        = (try? container.decode(Float.self,     forKey: .rain))        ?? 0.0
        self.snow        = (try? container.decode(Float.self,     forKey: .snow))        ?? 0.0
        self.weather     = (try? container.decode([Weather].self, forKey: .weather))     ?? .init()
    }
}
