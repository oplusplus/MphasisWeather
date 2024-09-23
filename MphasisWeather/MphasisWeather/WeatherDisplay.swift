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
        VStack(spacing: 12) {
            Text(weatherData.name)
            Image(uiImage: weatherIcon)
                .imageScale(.large)
                .foregroundStyle(.tint)
            let summaryArray = weatherData.weather.compactMap { $0.summary }
            if !summaryArray.isEmpty {
                Text("\(summaryArray.first!)")
            }
            let currentTemp = Int(weatherData.main.tempInFahrenheit.rounded())
            Text("\(currentTemp)F")
            let feelsLikeTemp = Int(weatherData.main.feelsLikeInFahrenheit.rounded())
            Text("Feels like \(feelsLikeTemp)F")
            let maxTemp = Int(weatherData.main.maxTempInFahrenheit.rounded())
            Text("Today's high: \(maxTemp)F")
            let minTemp = Int(weatherData.main.minTempInFarenheit.rounded())
            Text("Today's low: \(minTemp)F")
            Text("Humidity: \(weatherData.main.humidity)%")
            let windSpeed = Int(weatherData.wind.speedInMPH.rounded())
            Text("Wind blowing \(getDirectionFromDegrees(weatherData.wind.degrees)) at \(windSpeed)mph")
            Text("Sunrise at \(weatherData.sunriseAsDate)")
            Text("Sunset at \(weatherData.sunsetAsDate)")
//            Text("Visibility: \(Int(Double(weatherData.visibility / 100).rounded()))%")
        }
        .padding()
    }
    
    func getDirectionFromDegrees(_ degrees: Int) -> String {
        if degrees > 337 || degrees <= 22 {
            return "N"
        } else if degrees > 22 && degrees <= 68 {
            return "NE"
        } else if degrees > 68 && degrees <= 112 {
            return "E"
        } else if degrees > 112 && degrees <= 158 {
            return "SE"
        } else if degrees > 158 && degrees <= 202 {
            return "S"
        } else if degrees > 202 && degrees <= 248 {
            return "SW"
        } else if degrees > 248 && degrees <= 292 {
            return "W"
        } else if degrees > 292 && degrees <= 337 {
            return "NW"
        }
        return "No direction detected"
    }
    
}
