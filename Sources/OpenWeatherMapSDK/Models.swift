//
//  File.swift
//  
//
//  Created by Vladimir Psyukalov on 5/13/21.
//

import Foundation

public struct Coordinates: Decodable, CustomStringConvertible {
    
    enum CoordinatesCodingKey: String, CodingKey {
        
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

public struct Weather: Decodable, CustomStringConvertible {
    
    enum WeatherCodingKey: String, CodingKey {
        
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

public struct CurrentMain: Decodable, CustomStringConvertible {
    
    enum CurrentMainCodingKey: String, CodingKey {
        
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

public struct Wind: Decodable, CustomStringConvertible {
    
    enum WindCodingKey: String, CodingKey {
        
        case speed   = "speed"
        case degrees = "deg"
        case gust    = "gust"
    }
    
    public var speed:   Float
    public var degrees: Float
    public var gust:    Float
    
    public var description: String {
        return "(speed: \(speed), degrees: \(degrees), gust: \(gust))"
    }
    
    internal init() {
        self.speed   = 0.0
        self.degrees = 0.0
        self.gust    = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WindCodingKey.self)
        
        self.speed   = (try? container.decode(Float.self, forKey: .speed))   ?? 0.0
        self.degrees = (try? container.decode(Float.self, forKey: .degrees)) ?? 0.0
        self.gust    = (try? container.decode(Float.self, forKey: .gust))    ?? 0.0
    }
}

public struct Clouds: Decodable, CustomStringConvertible {
    
    enum CloudsCodingKey: String, CodingKey {
        
        case all = "all"
    }
    
    public var all: Float
    
    public var description: String {
        return "(all: \(all))"
    }
    
    internal init() {
        self.all = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CloudsCodingKey.self)
        
        self.all = (try? container.decode(Float.self, forKey: .all)) ?? 0.0
    }
}

public struct Hours: Decodable, CustomStringConvertible {
    
    enum HoursCodingKey: String, CodingKey {
        
        case h1 = "1h"
        case h3 = "3h"
    }
    
    public var h1: Float
    public var h3: Float
    
    public var description: String {
        return "(1: \(h1), 3: \(h3))"
    }
    
    internal init() {
        self.h1 = 0.0
        self.h3 = 0.0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HoursCodingKey.self)
        
        self.h1 = (try? container.decode(Float.self, forKey: .h1)) ?? 0.0
        self.h3 = (try? container.decode(Float.self, forKey: .h3)) ?? 0.0
    }
}

public struct System: Decodable, CustomStringConvertible {
    
    enum SystemCodingKey: String, CodingKey {
        
        case country = "country"
        case sunrise = "sunrise"
        case sunset  = "sunset"
    }
    
    public var country: String
    
    public var sunrise: Int
    public var sunset:  Int
    
    public var description: String {
        return "(country: \(country), sunrise: \(sunrise), sunset: \(sunset))"
    }
    
    internal init() {
        self.country = ""
        self.sunrise = 0
        self.sunset  = 0
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SystemCodingKey.self)
        
        self.country = (try? container.decode(String.self, forKey: .country)) ?? ""
        self.sunrise = (try? container.decode(Int.self,    forKey: .sunrise)) ?? 0
        self.sunset  = (try? container.decode(Int.self,    forKey: .sunset))  ?? 0
    }
}

public struct CurrentWeather: Decodable, CustomStringConvertible {
    
    enum CurrentWeatherCodingKey: String, CodingKey {
        
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

public struct CurrentWeatherByRectangle: Decodable, CustomStringConvertible {
    
    public var description: String {
        return ""
    }
}

public struct CurrentWeatherByCircle: Decodable, CustomStringConvertible {
    
    public var description: String {
        return ""
    }
}

struct JSONError: Decodable, CustomStringConvertible {
    
    enum JSONErrorCodingKey: String, CodingKey {
        
        case code    = "cod"
        case message = "message"
    }
    
    var code: String
    var message: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONErrorCodingKey.self)
        
        self.code    = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
    }
    
    var description: String {
        return "(code: \(code), message: \(message))"
    }
}
