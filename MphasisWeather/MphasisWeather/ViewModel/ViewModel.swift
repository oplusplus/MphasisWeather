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
    
    func fetchData(city: String) async throws {
        let formattedCity = city.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(formattedCity)&appid=d2ba2173027054ab4e64886bc1a7ffb0")!
        let (data, _) = try await URLSession.shared.data(from: url)
        weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        guard let weatherData else { return }
        let iconCodeArray = weatherData.weather.compactMap { $0.iconCode }
        if !iconCodeArray.isEmpty {
            icon = try await fetchIcon(iconCodeArray.first!)
        }
        return
    }
    
    func fetchLocationName(lat: Double, long: Double) async throws -> String {
        let url = URL(string: "http://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(long)&limit=2&appid=985189ad0a7a2871c8f0d832c4f424c1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let results = try JSONDecoder().decode([ReverseGeocoding].self, from: data)
        return results.first?.name ?? ""
    }
    
    func fetchIcon(_ iconCode: String) async throws -> UIImage? {
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
