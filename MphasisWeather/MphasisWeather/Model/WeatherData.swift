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
    var timeOffset: Int { 14400 }
    
    var sunriseAsTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeInterval = daylightDetails.sunriseInUNIXTimestamp + timezone + timeOffset
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        return formatter.string(from: date)
        
    }
    var sunsetAsTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeInterval = daylightDetails.sunsetInUNIXTimestamp + timezone + timeOffset
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
