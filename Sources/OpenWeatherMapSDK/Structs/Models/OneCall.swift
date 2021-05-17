
import Foundation

public struct OneCall: Decodable, CustomStringConvertible {
    
    private enum OneCallCodingKey: String, CodingKey {
        
        case lat            = "lat"
        case lon            = "lon"
        case timezone       = "time_zone"
        case timezoneOffset = "timezone_offset"
        case current        = "current"
        case minutely       = "minutely"
        case hourly         = "hourly"
        case daily          = "daily"
        case alerts         = "alerts"
    }
    
    public var lat:            Float
    public var lon:            Float
    
    public var timezone:       Int
    public var timezoneOffset: Int
    
    public var current: OneCallCurrent
    
    public var minutely: [Minutely]
    
    public var hourly: [OneCallCurrent]
    
    public var daily: [Daily]
    
    public var alerts: [Alert]
    
    init() {
        self.lat            = 0.0
        self.lon            = 0.0
        self.timezone       = 0
        self.timezoneOffset = 0
        self.current        = .init()
        self.minutely       = .init()
        self.hourly         = .init()
        self.daily          = .init()
        self.alerts         = .init()
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OneCallCodingKey.self)
        self.lat            = (try? container.decode(Float.self,            forKey: .lat))            ?? 0.0
        self.lon            = (try? container.decode(Float.self,            forKey: .lon))            ?? 0.0
        self.timezone       = (try? container.decode(Int.self,              forKey: .timezone))       ?? 0
        self.timezoneOffset = (try? container.decode(Int.self,              forKey: .timezoneOffset)) ?? 0
        self.current        = (try? container.decode(OneCallCurrent.self,   forKey: .current))        ?? .init()
        self.minutely       = (try? container.decode([Minutely].self,       forKey: .minutely))       ?? .init()
        self.hourly         = (try? container.decode([OneCallCurrent].self, forKey: .hourly))         ?? .init()
        self.daily          = (try? container.decode([Daily].self,          forKey: .daily))          ?? .init()
        self.alerts         = (try? container.decode([Alert].self,          forKey: .alerts))         ?? .init()
    }
    
    public var description: String {
        return "(lat: \(lat), lon: \(lon), timezone: \(timezone), timezone offset: \(timezoneOffset), current: \(current), minutely: \(minutely), hourly: \(hourly), daily: \(daily), alerts: \(alerts))"
    }
}
