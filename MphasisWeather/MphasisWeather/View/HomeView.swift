//
//  ContentView.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/22/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State var city = LAST_CITY_SEARCHED
    @State var showWeather = false
    let hvm = HomeViewModel()
    @State var error: Error? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TextField("City", text: $city)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.blue)
            Button("Get weather for selected city") {
                Task {
                    do { try await hvm.fetchData(city: city)
                        if let data = hvm.weatherData, let icon = hvm.icon { //make sure we have data before launching display screen.
                            LAST_CITY_SEARCHED = city
                            showWeather = true
                        }
                    } catch {
                        self.error = error
                    }
                }
            }
            .sheet(isPresented: $showWeather) {
                if let data = hvm.weatherData, let icon = hvm.icon {
                    let coordinator = Coordinator(weatherData: data, icon: icon)
                    coordinator.view()
                }
            }
            Button("Get weather for your current location") {
                Task {
                    await getWeatherByCoordinates()
                }
            }
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
            Task {
                await getWeatherByCoordinates()
            }
        }
        .padding()
        .errorAlert(error: $error)
    }
    
    func getWeatherByCoordinates() async { //If given more time, I would look into creating a callback upon initial location permission selection that calls the following code where lastKnownLocation is not nil. This will create going to WeatherDisplay view upon the initial granting of location.
        if let coordinate = locationManager.lastKnownLocation {
            do {
                let name = try await hvm.fetchLocationName(lat: coordinate.latitude, long: coordinate.longitude)
                try await hvm.fetchData(city: name)
                showWeather = true
            } catch {
                self.error = error
            }
        }
    }
}

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.localizedDescription ?? "")
        }
    }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError
    var localizedDescription: String? {
        underlyingError.localizedDescription
    }
    
    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}
