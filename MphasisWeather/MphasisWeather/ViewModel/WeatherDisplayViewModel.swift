//
//  WeatherDisplayViewModel.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/25/24.
//
import SwiftUI

class WeatherDisplayViewModel {
    var weatherData: WeatherData
    var icon: UIImage

    init(weatherData: WeatherData, icon: UIImage) {
        self.weatherData = weatherData
        self.icon = icon
    }
    
    func getMainView() -> some View {
        ScrollView {
            VStack(spacing: 12) {
                Text(weatherData.name)
                    .font(.system(size: 36))
                Image(uiImage: icon)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                let summaryArray = weatherData.weather.compactMap { $0.summary }
                if !summaryArray.isEmpty {
                    Text(summaryArray.first!.capitalizedSentence)
                }
                let currentTempF = Int(weatherData.main.tempInFahrenheit.rounded())
                let currentTempC = Int(weatherData.main.tempInCelsius.rounded())
                Text("\(currentTempF)F / \(currentTempC)C")
                let feelsLikeTempF = Int(weatherData.main.feelsLikeInFahrenheit.rounded())
                let feelsLikeTempC = Int(weatherData.main.feelsLikeInCelsius.rounded())
                Text("Feels like \(feelsLikeTempF)F / \(feelsLikeTempC)C")
                let maxTempF = Int(weatherData.main.maxTempInFahrenheit.rounded())
                let maxTempC = Int(weatherData.main.maxTempInCelsius.rounded())
                Text("Today's high: \(maxTempF)F / \(maxTempC)C")
                let minTempF = Int(weatherData.main.minTempInFahrenheit.rounded())
                let minTempC = Int(weatherData.main.minTempInCelsius.rounded())
                Text("Today's low: \(minTempF)F / \(minTempC)C")
                Text("Humidity: \(weatherData.main.humidity)%")
                let windSpeed = Int(weatherData.wind.speedInMPH.rounded())
                Text("Wind blowing \(getDirectionFromDegrees(weatherData.wind.degrees)) at \(windSpeed) mph")
                Text("Sunrise at \(weatherData.sunriseAsTime)")
                Text("Sunset at \(weatherData.sunsetAsTime)")
            }
        }
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

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
