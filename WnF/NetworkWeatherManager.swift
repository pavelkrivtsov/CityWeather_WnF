//
//  NetworkWeatherManager.swift
//  WnF
//
//  Created by Павел Кривцов on 02.09.2021.
//

import Foundation
import CoreLocation


class NetworkWeatherManager {
    
    private let apiKey = "3ec87d75-3271-4857-a630-7d64a489526c"
    private let HTTPHeader = "X-Yandex-API-Key"
    
    func getCityWeahter(citiesArray: [String], completionHeandler: @escaping (Int, Weather) -> ()) {
        for (index, city) in citiesArray.enumerated() {
            getCityCoordinates(ofCity: city) { [weak self] coordinate, error in
                guard let self = self else { return }
                guard let coordinate = coordinate, error == nil else { return }
                
                self.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                    completionHeandler(index, weather)
                }
            }
        }
    }
    
    private func getCityCoordinates(ofCity city: String,
                                    onCompletion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { placemark, error in
            onCompletion(placemark?.first?.location?.coordinate, error)
        }
    }
    
    private func fetchWeather(latitude: Double, longitude: Double, onCompletion: @escaping (Weather) -> ()) {
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: HTTPHeader)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self, let data = data else { return }
            if let weather = self.parseJSON(withData: data) {
                onCompletion(weather)
            }
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(fromWeatherData: weatherData) else { return nil }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
