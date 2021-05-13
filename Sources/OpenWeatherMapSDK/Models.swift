//
//  File.swift
//  
//
//  Created by Vladimir Psyukalov on 5/13/21.
//

import Foundation

public struct Coordinates: Decodable, CustomStringConvertible {
    
    enum CoordinatesCodingKey: String, CodingKey {
        
        case lat
        case lon
    }
    
    var lat: Float
    var lon: Float
    
    public var description: String {
        return "(latitude: \(lat), longitude: \(lon))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoordinatesCodingKey.self)
        self.lat = try container.decode(Float.self, forKey: .lat)
        self.lon = try container.decode(Float.self, forKey: .lon)
    }
}

public struct Weather: Decodable, CustomStringConvertible {
    
    enum WeatherCodingKey: String, CodingKey {
        
        case id
        case main
        case text = "description"
        case iconName = "icon"
    }
    
    var id: Int
    
    var main:     String
    var text:     String
    var iconName: String
    
    public var description: String {
        return "(id: \(id), main: \(main), description: \(text), icon name: \(iconName))"
    }
}

public struct CurrentMain: Decodable, CustomStringConvertible {
    
    enum CurrentMainCodingKey: String, CodingKey {
        
        case temp
        case feelsLike      = "feels_like"
        case pressure
        case humidity
        case tempMin        = "temp_min"
        case tempMax        = "temp_max"
        case seaPressure    = "sea_level"
        case groundPressure = "grnd_level"
    }
    
    var temp:           Float
    var feelsLike:      Float
    var pressure:       Float
    var humidity:       Float
    var tempMin:        Float
    var tempMax:        Float
    var seaPressure:    Float
    var groundPressure: Float
    
    public var description: String {
        return "(temperature: \(temp) (min: \(tempMin), max: \(tempMax)), feels like: \(feelsLike), pressure: \(pressure) (sea: \(seaPressure), ground: \(groundPressure)), humidity: \(humidity)"
    }
}

public struct Wind: Decodable, CustomStringConvertible {
    
    enum WindCodingKey: String, CodingKey {
        
        case speed
        case degrees = "deg"
        case gust
    }
    
    var speed:   Float
    var degrees: Float
    var gust:    Float
    
    public var description: String {
        return "(speed: \(speed), degrees: \(degrees), gust: \(gust))"
    }
}

public struct Clouds: Decodable, CustomStringConvertible {
    
    enum CloudsCodingKey: String, CodingKey {
        
        case all
    }
    
    var all: Int
    
    public var description: String {
        return "(all: \(all))"
    }
}

public struct Hours: Decodable, CustomStringConvertible {
    
    enum HoursCodingKey: String, CodingKey {
        
        case one   = "1h"
        case three = "3h"
    }
    
    var one:   Float
    var three: Float
    
    public var description: String {
        return ("1: \(one), 3: \(three))")
    }
}

public struct System: Decodable, CustomStringConvertible {
    
    enum SystemCodingKey: String, CodingKey {
        
        case country
        case sunrise
        case sunset
    }
    
    var country: String
    
    var sunrise: Int
    var sunset:  Int
    
    public var description: String {
        return "(country: \(country), sunrise: \(sunrise), sunset: \(sunset))"
    }
}

public struct CurrentWeather: Decodable, CustomStringConvertible {
    
    enum CurrentWeatherCodingKey: String, CodingKey {
        
        case coordinates = "coord"
//        case weather
//        case main
//        case wind
//        case clouds
//        case rain
//        case snow
//        case date = "dt"
//        case system = "sys"
//        case timezone
//        case cityId = "id"
//        case cityName = "name"
    }
    
    var coordinates: Coordinates
    
//    var weather: Weather
//
//    var main: CurrentMain
//
//    var clouds: Clouds
//
//    var rain: Hours
//    var snow: Hours
//
//    var date: Int
//
//    var system: System
//
//    var timezone: Int
//
//    var cityId:   Int
//
//    var cityName: String
    
    public var description: String {
        return "coord: \(coordinates)"
//        return "(coordinates: \(coordinates), weather: \(weather), main: \(main), clouds: \(clouds), rain: \(rain), show: \(snow), date: \(date), system: \(system), timezone: \(timezone), cityId: \(cityId), cityName: \(cityName))"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentWeatherCodingKey.self)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
    }
}
