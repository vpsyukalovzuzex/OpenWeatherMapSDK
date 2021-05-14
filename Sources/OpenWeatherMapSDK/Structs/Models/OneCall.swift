
import Foundation

public struct OneCall: Decodable {
    
}

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
        case windSpeed   = "windSpeed"
        case windGust    = "windGust"
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

public struct Temp: Decodable, CustomStringConvertible {
    
    private enum TempCodingKey: String, CodingKey {
        
        case morning = "morn"
        case day     = "day"
        case evening = "eve"
        case night   = "night"
        case min     = "min"
        case max     = "max"
    }
    
    public var morning: Float
    public var day:     Float
    public var evening: Float
    public var night:   Float
    public var min:     Float
    public var max:     Float
    
    public var description: String {
        return "(morning: \(morning), day: \(day), evening: \(evening), night: \(night), min: \(min), max: \(max))"
    }
    
    public init() {
        self.morning = 0.0
        self.day     = 0.0
        self.evening = 0.0
        self.night   = 0.0
        self.min     = 0.0
        self.max     = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TempCodingKey.self)
        
        self.morning = (try? container.decode(Float.self, forKey: .morning)) ?? 0.0
        self.day     = (try? container.decode(Float.self, forKey: .day))     ?? 0.0
        self.evening = (try? container.decode(Float.self, forKey: .evening)) ?? 0.0
        self.night   = (try? container.decode(Float.self, forKey: .night))   ?? 0.0
        self.min     = (try? container.decode(Float.self, forKey: .min))     ?? 0.0
        self.max     = (try? container.decode(Float.self, forKey: .max))     ?? 0.0
    }
}

public struct Alert: Decodable, CustomStringConvertible {
    
    private enum AlertCodingKey: String, CodingKey {
        
        case senderName = "sender_name"
        case event      = "event"
        case start      = "start"
        case end        = "end"
        case text       = "description"
    }
    
    public var senderName: String
    public var event:      String
    public var start:      Int
    public var end:        Int
    public var text:       String
    
    public init() {
        self.senderName = ""
        self.event      = ""
        self.start      = 0
        self.end        = 0
        self.text       = ""
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlertCodingKey.self)
        
        self.senderName = (try? container.decode(String.self, forKey: .senderName)) ?? ""
        self.event      = (try? container.decode(String.self, forKey: .event))      ?? ""
        self.start      = (try? container.decode(Int.self,    forKey: .start))      ?? 0
        self.end        = (try? container.decode(Int.self,    forKey: .end))        ?? 0
        self.text       = (try? container.decode(String.self, forKey: .text))       ?? ""
    }
    
    public var description: String {
        return "(sender name: \(senderName), event: \(event), start: \(start), end: \(end), text: \(text))"
    }
}
