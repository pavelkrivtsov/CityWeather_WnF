//
//  GetCitiesWeather.swift
//  WnF
//
//  Created by Павел Кривцов on 04.09.2021.
//

import Foundation
import CoreLocation


let networkWeatherManager = NetworkWeatherManager()

func getCityWeahter(citiesArray: [String], completionHeandler: @escaping (Int, Weather) -> ()) {
    for (index, city) in citiesArray.enumerated() {
        getCityCoordinates(ofCity: city) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            networkWeatherManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                completionHeandler(index, weather)
            }
        }
    }
}

func getCityCoordinates(ofCity city: String,
                        onCompletion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        onCompletion(placemark?.first?.location?.coordinate, error)
    }
}

