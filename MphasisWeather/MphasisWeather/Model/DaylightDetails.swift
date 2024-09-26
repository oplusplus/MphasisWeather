//
//  DaylightDetails.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/24/24.
//


struct DaylightDetails: Codable, Equatable {
    let sunriseInUNIXTimestamp: Int
    let sunsetInUNIXTimestamp: Int
}

extension DaylightDetails {
    enum CodingKeys: String, CodingKey {
        case sunriseInUNIXTimestamp = "sunrise"
        case sunsetInUNIXTimestamp = "sunset"
    }
}
