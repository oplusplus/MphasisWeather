//
//  ContentView.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/22/24.
//


/*
 WHAT'S LEFT TO DO:
 TESTS
 ADD COMMENTS DESCRIBING CODE AND WHAT I WOULD DO WITH MORE TIME
 CLEAN UP ORGANIZE (MODEL FILES FOR EXAMPLE)
 */

import SwiftUI

struct HomeView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State var city = LAST_CITY_SEARCHED
    @State var showWeather = false
    let vm = ViewModel()
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
                    do { try await vm.fetchData(city: city)
                        LAST_CITY_SEARCHED = city
                        showWeather = true
                    } catch {
                        self.error = error
                    }
                }
            }
            .sheet(isPresented: $showWeather) {
                if let data = vm.weatherData, let icon = vm.icon {
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
    
    func getWeatherByCoordinates() async {
        if let coordinate = locationManager.lastKnownLocation {
            do {
                let name = try await vm.fetchLocationName(lat: coordinate.latitude, long: coordinate.longitude)
                try await vm.fetchData(city: name)
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
    var errorDescription: String? {
        underlyingError.errorDescription
    }
    var recoverySuggestion: String? {
        underlyingError.recoverySuggestion
    }
    var localizedDescription: String? {
        underlyingError.localizedDescription
    }
    
    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}
