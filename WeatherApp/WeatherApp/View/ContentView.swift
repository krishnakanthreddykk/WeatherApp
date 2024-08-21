//
//  ContentView.swift
//  WeatherApp
//
//  Created by Krishna Kanth Reddy Podduturi on 8/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var weather: WeatherResponse?

    var body: some View {
        VStack {
            TextField("Enter city name", text: $city)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                fetchWeather()
            }) {
                Text("Get Weather")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            if let weather = weather {
                Text("Weather in \(weather.name)")
                    .font(.title)
                    .padding()

                Text("Temperature: \(weather.main.temp, specifier: "%.1f")°C")
                    .font(.headline)

                Text("Humidity: \(weather.main.humidity)%")
                    .font(.subheadline)

                Text("Description: \(weather.weather.first?.description ?? "N/A")")
                    .font(.subheadline)
            }
        }
        .padding()
    }

    private func fetchWeather() {
        WeatherService().fetchWeather(for: city) { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weather = weather
                }
            case .failure(let error):
                print("Failed to fetch weather: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
