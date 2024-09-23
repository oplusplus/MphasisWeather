//
//  Coordinator.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/23/24.
//

import SwiftUI

class Coordinator: ObservableObject {
    
    @State var weatherData: WeatherData
    @State var icon: UIImage
    
    init(weatherData: WeatherData, icon: UIImage) {
        self.weatherData = weatherData
        self.icon = icon
    }
}
