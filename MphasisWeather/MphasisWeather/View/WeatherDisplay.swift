//
//  WeatherDisplay.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/23/24.
//

import SwiftUI

struct WeatherDisplay: View {
    
    @State var weatherData: WeatherData
    @State var weatherIcon: UIImage

    
    var body: some View {
        let weatherDisplayViewModel: WeatherDisplayViewModel = WeatherDisplayViewModel(weatherData: weatherData, icon: weatherIcon)
        weatherDisplayViewModel.getMainView()
        .padding()
    }
}
