//
//  WeatherData.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/23/24.
//
import SwiftUI

struct WeatherData: Codable {
    let coord: Coordinates
    let weather: [WeatherOverview]
    let main: WeatherDetails
    let visibility: Int
    let wind: Wind
    let daylightDetails: DaylightDetails
    let timezone: Int
    let id: Int
    let name: String
    let code: Int
}

extension WeatherData {
    var sunriseAsDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeInterval = daylightDetails.sunriseInUNIXTimestamp
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        return formatter.string(from: date)
        
    }
    var sunsetAsDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeInterval = daylightDetails.sunsetInUNIXTimestamp
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        return formatter.string(from: date)
    }
    enum CodingKeys: String, CodingKey {
        case daylightDetails = "sys"
        case code = "cod"
        case coord
        case weather
        case main
        case visibility
        case wind
        case timezone
        case id
        case name
    }
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct WeatherOverview: Codable {
    let id: Int
    let overview: String
    let summary: String
    let iconCode: String
}

extension WeatherOverview {
    enum CodingKeys: String, CodingKey {
        case overview = "main"
        case iconCode = "icon"
        case summary = "description"
        case id
    }
}

struct WeatherDetails: Codable {
    let tempInKelvin: Double
    let feelsLikeInKelvin: Double
    let minTempInKelvin: Double
    let maxTempInKelvin: Double
    let humidity: Int
}

extension WeatherDetails {
    var tempInCelsius: Double { tempInKelvin - 273.15 }
    var tempInFahrenheit: Double { (tempInCelsius * 9 / 5) + 32 }
    var feelsLikeInCelsius: Double { feelsLikeInKelvin - 273.15 }
    var feelsLikeInFahrenheit: Double { (feelsLikeInCelsius * 9 / 5) + 32 }
    var minTempInCelsius: Double { minTempInKelvin - 273.15 }
    var minTempInFarenheit: Double { (minTempInCelsius * 9 / 5) + 32 }
    var maxTempInCelsius: Double { maxTempInKelvin - 273.15 }
    var maxTempInFahrenheit: Double { (maxTempInCelsius * 9 / 5) + 32 }
    
    enum CodingKeys: String, CodingKey {
        case tempInKelvin = "temp"
        case feelsLikeInKelvin = "feels_like"
        case minTempInKelvin = "temp_min"
        case maxTempInKelvin = "temp_max"
        case humidity
    }
}

struct Wind: Codable {
    let speed: Double
    let degrees: Int
}

extension Wind {
    var speedInMPH: Double {
        speed / 2.23694
    }
}

extension Wind {
    enum CodingKeys: String, CodingKey {
        case degrees = "deg"
        case speed
    }
}

struct DaylightDetails: Codable {
    let sunriseInUNIXTimestamp: Int
    let sunsetInUNIXTimestamp: Int
}

extension DaylightDetails {
    enum CodingKeys: String, CodingKey {
        case sunriseInUNIXTimestamp = "sunrise"
        case sunsetInUNIXTimestamp = "sunset"
    }
}
