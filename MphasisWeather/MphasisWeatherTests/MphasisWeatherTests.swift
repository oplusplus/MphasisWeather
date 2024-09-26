//
//  MphasisWeatherTests.swift
//  MphasisWeatherTests
//
//  Created by Michael deBoisblanc on 9/22/24.
//

import Testing
@testable import MphasisWeather
import UIKit
import CoreLocation

struct MphasisWeatherTests {
    
    private let weatherData = WeatherData(
        coord: Coordinates(
            lat: 40.7128,
            lon: -73.935242),
        weather:
            [.init(
                id: 233,
                overview: "partly cloudy",
                summary: "clouds",
                iconCode: "04n")
            ],
        main:
            WeatherDetails(
                tempInKelvin: 291,
                feelsLikeInKelvin: 291,
                minTempInKelvin: 290,
                maxTempInKelvin: 292,
                humidity: 66),
        visibility: 10000,
        wind: Wind(speed: 8,
                   degrees: 86),
        daylightDetails: DaylightDetails(
            sunriseInUNIXTimestamp: 1727174746,
            sunsetInUNIXTimestamp: 1727218179),
        timezone: -14400,
        id: 65,
        name: "New York",
        code: 200
    )

    @Test func testLocationManager() async throws {
        let lm = LocationManager()
        #expect(lm.lastKnownLocation == nil && lm.manager.delegate == nil)
        lm.checkLocationAuthorization()
        #expect(lm.manager.delegate != nil)
        let lat = 40.7128
        let long = -73.935242
        let location = CLLocation(latitude: lat, longitude: long)
        lm.locationManager(lm.manager, didUpdateLocations: [location])
        #expect(lm.lastKnownLocation != nil && lm.lastKnownLocation!.latitude == lat && lm.lastKnownLocation!.longitude == long)
    }
    
    @Test func testGetDirectionFromDegrees() {
        let display = WeatherDisplay(weatherData: weatherData, weatherIcon: UIImage())
        let weatherDisplayViewModel = WeatherDisplayViewModel(weatherData: display.weatherData, icon: display.weatherIcon)
        let resultN = weatherDisplayViewModel.getDirectionFromDegrees(3)
        let resultNE = weatherDisplayViewModel.getDirectionFromDegrees(39)
        let resultE = weatherDisplayViewModel.getDirectionFromDegrees(70)
        let resultSE = weatherDisplayViewModel.getDirectionFromDegrees(140)
        let resultS = weatherDisplayViewModel.getDirectionFromDegrees(175)
        let resultSW = weatherDisplayViewModel.getDirectionFromDegrees(210)
        let resultW = weatherDisplayViewModel.getDirectionFromDegrees(270)
        let resultNW = weatherDisplayViewModel.getDirectionFromDegrees(298)
        
        #expect(resultN == "N" && resultNE == "NE" && resultE == "E" && resultSE == "SE" && resultS == "S" && resultSW == "SW" && resultW == "W" && resultNW == "NW")
    }
    
   @Test func testHomeViewModelHappyPath() async throws {
       let service = MockNetworkService()
       let vm = HomeViewModel(service: service)
       try await vm.fetchData(city: "New York")
       #expect(vm.weatherData != nil && vm.icon != nil)
    }
    
    @Test func testHomeViewModelUnhappyPath() async throws {
        let service = MockNetworkService()
        let vm = HomeViewModel(service: service)
        try await vm.fetchData(city: "Fake city name")
        #expect(vm.weatherData == nil && vm.icon == nil)
     }

}

struct MockNetworkService: NetworkServiceable {
        
    func fetchData(city: String) async throws -> WeatherData? {
        if city == "New York" {
            let weatherData = WeatherData(
                coord: Coordinates(
                    lat: 40.7128,
                    lon: -73.935242),
                weather:
                    [.init(
                        id: 233,
                        overview: "partly cloudy",
                        summary: "clouds",
                        iconCode: "04n")
                    ],
                main:
                    WeatherDetails(
                        tempInKelvin: 291,
                        feelsLikeInKelvin: 291,
                        minTempInKelvin: 290,
                        maxTempInKelvin: 292,
                        humidity: 66),
                visibility: 10000,
                wind: Wind(speed: 8,
                           degrees: 86),
                daylightDetails: DaylightDetails(
                    sunriseInUNIXTimestamp: 1727174746,
                    sunsetInUNIXTimestamp: 1727218179),
                timezone: -14400,
                id: 65,
                name: "New York",
                code: 200
            )
            return weatherData
        } else {
            return nil
        }
    }
    
    func fetchIcon(iconCode: String) async -> UIImage? {
        return UIImage()
    }
    
    func fetchNameFromLocation(lat: Double, long: Double) async throws -> String {
        return "New York"
    }
    
}
