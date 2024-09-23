//
//  ContentView.swift
//  MphasisWeather
//
//  Created by Michael deBoisblanc on 9/22/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var city = "New York"
    @State var showWeather = false
    let vm = ViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TextField("City", text: $city)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.blue)
            Button("Get weather") {
                Task {
                    await vm.fetchData(city: city)
                    showWeather = true
                }
            }
            .sheet(isPresented: $showWeather) {
                if let data = vm.weatherData, let icon = vm.icon {
                    WeatherDisplay(weatherData: data, weatherIcon: icon)
                }
            }
        }
        .padding()
    }
}
