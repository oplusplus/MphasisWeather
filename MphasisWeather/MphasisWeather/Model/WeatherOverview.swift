//
//  WeatherOverview.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/24/24.
//


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
