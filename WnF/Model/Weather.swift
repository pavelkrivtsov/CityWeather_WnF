//
//  Weather.swift
//  WnF
//
//  Created by Павел Кривцов on 02.09.2021.
//

import Foundation


struct Weather {
    
    var name: String = "Название города"
    var url: String = ""
    var temperature: Int = 0
    var feelsLike: Int = 0
    var pressureMm: Int = 0
    var humidity: Int = 0
    var windSpeed: Double = 0
    var condition: String = ""
    
    var conditionIcon: String {
        switch condition {
        case "clear": return "moon.stars"
        case "partly-cloudy": return "cloud"
        case "cloudy": return "cloud.sun"
        case "overcast": return "cloud.sun.rain"
        case "drizzle": return "cloud.drizzle"
        case "light-rain": return "cloud.rain"
        case "rain": return "cloud.rain"
        case "moderate-rain": return "cloud.rain"
        case "heavy-rain": return "cloud.heavyrain"
        case "continuous-heavy-rain": return "cloud.heavyrain"
        case "showers": return "cloud.heavyrain"
        case "wet-snow": return "cloud.snow"
        case "light-snow": return "cloud.snow"
        case "snow": return "cloud.snow"
        case "snow-showers": return "cloud.snow"
        case "hail": return "cloud.hail"
        case "thunderstorm": return "cloud.bolt"
        case "thunderstorm-with-rain": return "cloud.bolt.rain"
        case "thunderstorm-with-hail": return "cloud.hail"
        default: return "Описание погоды"
        }
    }
    
    var conditionString: String {
        switch condition {
        case "clear": return "Ясно"
        case "partly-cloudy": return "Малооблачно"
        case "cloudy": return "Облачно с прояснениями"
        case "overcast": return "Пасмурно"
        case "drizzle": return "Морось"
        case "light-rain": return "Небольшой дождь"
        case "rain": return "Дождь"
        case "moderate-rain": return "Умеренно сильный дождь"
        case "heavy-rain": return "Сильный дождь"
        case "continuous-heavy-rain": return "Длительный сильный дождь"
        case "showers": return "Ливень"
        case "wet-snow": return "Дождь со снегом"
        case "light-snow": return "Небольшой снег"
        case "snow": return "Снег"
        case "snow-showers": return "Снегопад"
        case "hail": return "Град"
        case "thunderstorm": return "Гроза"
        case "thunderstorm-with-rain": return "Дождь с грозой"
        case "thunderstorm-with-hail": return "Дождь с градом"
        default: return "Описание погоды"
        }
    }
    
    init?(fromWeatherData weatherdata: WeatherData) {
        self.url = weatherdata.info.url
        self.temperature = weatherdata.fact.temp
        self.feelsLike = weatherdata.fact.feelsLike
        self.windSpeed = weatherdata.fact.windSpeed
        self.pressureMm = weatherdata.fact.pressureMm
        self.condition = weatherdata.fact.condition
        self.humidity = weatherdata.fact.humidity
    }
    
    init() {}
}
