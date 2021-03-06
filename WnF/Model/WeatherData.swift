//
//  WeatherData.swift
//  WnF
//
//  Created by Павел Кривцов on 02.09.2021.
//

import Foundation

struct WeatherData: Decodable {
    let info: Info
    let fact: Fact
}

struct Info: Decodable {
    let url: String
}

struct Fact: Decodable {
    let temp, feelsLike: Int
    let condition: String
    let windSpeed: Double
    let pressureMm: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
        case humidity
    }
}
