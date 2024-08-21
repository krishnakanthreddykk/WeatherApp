//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Krishna Kanth Reddy Podduturi on 8/21/24.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
}
