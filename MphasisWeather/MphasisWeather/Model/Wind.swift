//
//  Wind.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/24/24.
//

struct Wind: Codable, Equatable {
    let speed: Double
    let degrees: Int
}

extension Wind {
    var speedInMPH: Double {
        speed / 2.23694
    }
    
    enum CodingKeys: String, CodingKey {
        case degrees = "deg"
        case speed
    }
}
