//
//  ViewModel.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/23/24.
//
import UIKit

class ViewModel: ObservableObject {
    @Published var weatherData: WeatherData? = nil
    @Published var icon: UIImage? = nil
    
    func fetchData(city: String) async {
        let formattedCity = city.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(formattedCity)&appid=d2ba2173027054ab4e64886bc1a7ffb0")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            print("***** TimeZone", weatherData?.timezone)
            guard let weatherData else { return }
            let iconCodeArray = weatherData.weather.compactMap { $0.iconCode }
            if !iconCodeArray.isEmpty {
                icon = await fetchIcon(iconCodeArray.first!)
            }
        } catch {
            print(error)
        }
        return
    }
    
    func fetchIcon(_ iconCode: String) async -> UIImage? {
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print(error)
        }
        return nil
    }
}
