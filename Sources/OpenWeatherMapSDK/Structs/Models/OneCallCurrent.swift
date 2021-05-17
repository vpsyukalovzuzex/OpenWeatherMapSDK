
import Foundation

public struct OneCallCurrent: Decodable, CustomStringConvertible {
    
    private enum OneCallCurrentCodingKey: String, CodingKey {
        
        case date        = "dt"
        case sunrise     = "sunrise"
        case sunset      = "sunset"
        case temp        = "temp"
        case feelsLike   = "feels_like"
        case pressure    = "pressure"
        case humidity    = "humidity"
        case dewPoint    = "dew_point"
        case clouds      = "clouds"
        case uvi         = "uvi"
        case visibility  = "visibility"
        case windSpeed   = "wind_speed"
        case windGust    = "wind_gust"
        case windDegrees = "wind_deg"
        case rain        = "rain"
        case snow        = "snow"
        case weather     = "weather"
        case pop         = "pop"
    }
    
    public var date:    Int
    public var sunrise: Int
    public var sunset:  Int
    
    public var temp:        Float
    public var feelsLike:   Float
    public var pressure:    Float
    public var humidity:    Float
    public var dewPoint:    Float
    public var uvi:         Float
    public var clouds:      Float
    public var visibility:  Float
    public var windSpeed:   Float
    public var windDegrees: Float
    public var windGust:    Float
    
    public var rain: Hours
    public var snow: Hours
    
    public var pop: Int
    
    public var weather: [Weather]
    
    public var description: String {
        return "(date: \(date), sunrise: \(sunrise), sunset: \(sunset), temp: \(temp), feels like: \(feelsLike), pressure: \(pressure), humidity: \(humidity), dew point: \(dewPoint), uvi: \(uvi), clouds: \(clouds), visibility: \(visibility), windSpeed: \(windSpeed), wind degrees: \(windSpeed), wind gust: \(windGust), rain: \(rain), snow: \(snow), weather: \(weather), probability of precipitation: \(pop))"
    }
    
    public init() {
        self.date        = 0
        self.sunrise     = 0
        self.sunset      = 0
        self.temp        = 0.0
        self.feelsLike   = 0.0
        self.pressure    = 0.0
        self.humidity    = 0.0
        self.dewPoint    = 0.0
        self.uvi         = 0.0
        self.clouds      = 0.0
        self.visibility  = 0.0
        self.windSpeed   = 0.0
        self.windDegrees = 0.0
        self.windGust    = 0.0
        self.rain        = .init()
        self.snow        = .init()
        self.weather     = .init()
        self.pop         = 0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OneCallCurrentCodingKey.self)
        
        self.date        = (try? container.decode(Int.self,       forKey: .date))        ?? 0
        self.sunrise     = (try? container.decode(Int.self,       forKey: .sunrise))     ?? 0
        self.sunset      = (try? container.decode(Int.self,       forKey: .sunset))      ?? 0
        self.temp        = (try? container.decode(Float.self,     forKey: .temp))        ?? 0.0
        self.feelsLike   = (try? container.decode(Float.self,     forKey: .feelsLike))   ?? 0.0
        self.pressure    = (try? container.decode(Float.self,     forKey: .pressure))    ?? 0.0
        self.humidity    = (try? container.decode(Float.self,     forKey: .humidity))    ?? 0.0
        self.dewPoint    = (try? container.decode(Float.self,     forKey: .dewPoint))    ?? 0.0
        self.uvi         = (try? container.decode(Float.self,     forKey: .uvi))         ?? 0.0
        self.clouds      = (try? container.decode(Float.self,     forKey: .clouds))      ?? 0.0
        self.visibility  = (try? container.decode(Float.self,     forKey: .visibility))  ?? 0.0
        self.windSpeed   = (try? container.decode(Float.self,     forKey: .windSpeed))   ?? 0.0
        self.windDegrees = (try? container.decode(Float.self,     forKey: .windDegrees)) ?? 0.0
        self.windGust    = (try? container.decode(Float.self,     forKey: .windGust))    ?? 0.0
        self.rain        = (try? container.decode(Hours.self,     forKey: .rain))        ?? .init()
        self.snow        = (try? container.decode(Hours.self,     forKey: .snow))        ?? .init()
        self.weather     = (try? container.decode([Weather].self, forKey: .weather))     ?? .init()
        self.pop         = (try? container.decode(Int.self,       forKey: .pop))         ?? 0
    }
}
