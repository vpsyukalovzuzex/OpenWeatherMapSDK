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
    
    var lat: Float?
    var lon: Float?
    
    public var description: String {
        return "(latitude: \(lat), longitude: \(lon))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoordinatesCodingKey.self)
        
        self.lat = try container.decode(Float.self, forKey: .latitude)
        self.lon = try container.decode(Float.self, forKey: .longitude)
    }
}

public struct Weather: Decodable, CustomStringConvertible {
    
    enum WeatherCodingKey: String, CodingKey {
        
        case id       = "id"
        case main     = "main"
        case text     = "description"
        case iconName = "icon"
    }
    
    var id: Int?
    
    var main:     String?
    var text:     String?
    var iconName: String?
    
    public var description: String {
        return "(id: \(id), main: \(main), description: \(text), icon name: \(iconName))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherCodingKey.self)
        
        self.id       = try container.decode(Int.self, forKey: .id)
        self.main     = try container.decode(String.self, forKey: .main)
        self.text     = try container.decode(String.self, forKey: .text)
        self.iconName = try container.decode(String.self, forKey: .iconName)
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
    
    var temp:           Float?
    var feelsLike:      Float?
    var pressure:       Float?
    var humidity:       Float?
    var tempMin:        Float?
    var tempMax:        Float?
    var seaPressure:    Float?
    var groundPressure: Float?
    
    public var description: String {
        return "(temperature: \(temp) (min: \(tempMin), max: \(tempMax)), feels like: \(feelsLike), pressure: \(pressure) (sea: \(seaPressure), ground: \(groundPressure)), humidity: \(humidity)"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentMainCodingKey.self)
        
        self.temp           = try container.decode(Float.self, forKey: .temp)
        self.feelsLike      = try container.decode(Float.self, forKey: .feelsLike)
        self.pressure       = try container.decode(Float.self, forKey: .pressure)
        self.humidity       = try container.decode(Float.self, forKey: .humidity)
        self.tempMin        = try container.decode(Float.self, forKey: .tempMin)
        self.tempMax        = try container.decode(Float.self, forKey: .tempMax)
        self.seaPressure    = try container.decode(Float.self, forKey: .seaPressure)
        self.groundPressure = try container.decode(Float.self, forKey: .groundPressure)
    }
}

public struct Wind: Decodable, CustomStringConvertible {
    
    enum WindCodingKey: String, CodingKey {
        
        case speed   = "speed"
        case degrees = "deg"
        case gust    = "gust"
    }
    
    var speed:   Float?
    var degrees: Float?
    var gust:    Float?
    
    public var description: String {
        return "(speed: \(speed), degrees: \(degrees), gust: \(gust))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WindCodingKey.self)
        
        self.speed   = try container.decode(Float.self, forKey: .speed)
        self.degrees = try container.decode(Float.self, forKey: .degrees)
        self.gust    = try container.decode(Float.self, forKey: .gust)
    }
}

public struct Clouds: Decodable, CustomStringConvertible {
    
    enum CloudsCodingKey: String, CodingKey {
        
        case all = "all"
    }
    
    var all: Float?
    
    public var description: String {
        return "(all: \(all))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CloudsCodingKey.self)
        
        self.all = try container.decode(Float.self, forKey: .all)
    }
}

public struct Hours: Decodable, CustomStringConvertible {
    
    enum HoursCodingKey: String, CodingKey {
        
        case h1 = "1h"
        case h3 = "3h"
    }
    
    var h1: Float?
    var h3: Float?
    
    public var description: String {
        return ("1: \(h1), 3: \(h3))")
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HoursCodingKey.self)
        
        self.h1 = try container.decode(Float.self, forKey: .h1)
        self.h3 = try container.decode(Float.self, forKey: .h3)
    }
}

public struct System: Decodable, CustomStringConvertible {
    
    enum SystemCodingKey: String, CodingKey {
        
        case country = "country"
        case sunrise = "sunrise"
        case sunset  = "sunset"
    }
    
    var country: String?
    
    var sunrise: Int?
    var sunset:  Int?
    
    public var description: String {
        return "(country: \(country), sunrise: \(sunrise), sunset: \(sunset))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SystemCodingKey.self)
        
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
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
    
    var coordinates: Coordinates?
    
    var weather: [Weather]?
    
    var main: CurrentMain?
    
    var clouds: Clouds?
    
    var rain: Hours?
    var snow: Hours?
    
    var date: Int?
    
    var system: System?
    
    var timezone: Int?
    
    var cityId: String?
    var cityName: String?
    
    public var description: String {
        return "(coordinates: \(coordinates), weather: \(weather), main: \(main), clouds: \(clouds), rain: \(rain), show: \(snow), date: \(date), system: \(system), timezone: \(timezone), cityId: \(cityId), cityName: \(cityName))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentWeatherCodingKey.self)
        
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.weather     = try container.decode([Weather].self, forKey: .weather)
        self.main        = try container.decode(CurrentMain.self, forKey: .main)
        self.clouds      = try container.decode(Clouds.self, forKey: .clouds)
        self.rain        = try container.decode(Hours.self, forKey: .rain)
        self.snow        = try container.decode(Hours.self, forKey: .snow)
        self.date        = try container.decode(Int.self, forKey: .date)
        self.system      = try container.decode(System.self, forKey: .system)
        self.timezone    = try container.decode(Int.self, forKey: .timezone)
        self.cityId      = try container.decode(String.self, forKey: .cityId)
        self.cityName    = try container.decode(String.self, forKey: .cityName)
    }
}
