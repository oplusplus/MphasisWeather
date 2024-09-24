//
//  WeatherDetails.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/24/24.
//

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
    var minTempInFahrenheit: Double { (minTempInCelsius * 9 / 5) + 32 }
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
