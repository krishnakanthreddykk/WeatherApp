//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Krishna Kanth Reddy Podduturi on 8/21/24.
//

import Foundation

struct WeatherService {
    private let apiKey = "515fe83a1a6e1318ef2343036783609c"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                
                // Print the entire JSON response
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("JSON Response: \(json)")
                }
                
                
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
    }
}
