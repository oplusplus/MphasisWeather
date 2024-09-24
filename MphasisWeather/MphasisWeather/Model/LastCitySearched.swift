//
//  LastCitySearched.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/24/24.
//
import SwiftUI

let lastCitySearchedUserDefaultKey = "com.ollify.MphasisWeather.lastCitySearched"

var LAST_CITY_SEARCHED: String {
    get {
        guard let rawValue = UserDefaults.standard.string(forKey: lastCitySearchedUserDefaultKey) else { return "" }
        return rawValue
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: lastCitySearchedUserDefaultKey)
    }
}
