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
        let location = CLLocation(latitude: 40.7128, longitude: -73.935242)
        lm.locationManager(lm.manager, didUpdateLocations: [location])
        #expect(lm.lastKnownLocation != nil && lm.lastKnownLocation!.latitude == 40.7128 && lm.lastKnownLocation!.longitude == -73.935242)
    }
    
    @Test func testGetDirectionFromDegrees() {
        let display = WeatherDisplay(weatherData: weatherData, weatherIcon: UIImage())
        let weatherDisplayViewModel = WeatherDisplayViewModel(weatherData: display.weatherData, icon: display.weatherIcon)
        let result1 = weatherDisplayViewModel.getDirectionFromDegrees(3) // N
        let result2 = weatherDisplayViewModel.getDirectionFromDegrees(39) // NE
        let result3 = weatherDisplayViewModel.getDirectionFromDegrees(70) // E
        let result4 = weatherDisplayViewModel.getDirectionFromDegrees(140) // SE
        let result5 = weatherDisplayViewModel.getDirectionFromDegrees(175) // S
        let result6 = weatherDisplayViewModel.getDirectionFromDegrees(210) // SW
        let result7 = weatherDisplayViewModel.getDirectionFromDegrees(270) // W
        let result8 = weatherDisplayViewModel.getDirectionFromDegrees(298) // NW
        
        #expect(result1 == "N" && result2 == "NE" && result3 == "E" && result4 == "SE" && result5 == "S" && result6 == "SW" && result7 == "W" && result8 == "NW")
    }

}
