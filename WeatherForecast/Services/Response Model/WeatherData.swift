//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 27/03/21.
//

//******
// MARK: - WeatherDataList
struct WeatherDataList: Codable {
    var cod: String?
    var message, cnt: Int?
    var list: [WeatherData]?
    var city: City?
}

// MARK: - City
struct City: Codable {
    var id: Int
    var name: String
    var coord: Coord
    var country: String
    var population, timezone, sunrise, sunset: Int
}

// ******

// MARK: - WeatherData
struct WeatherData: Codable {
    
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone, id: Int?
    var name: String?
    var cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double
    var pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int
    var country: String
    var sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double
    var deg: Int
}
