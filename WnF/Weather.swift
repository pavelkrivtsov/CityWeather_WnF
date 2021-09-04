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
    var temp: Int = 0
    var feelsLike: Int = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    var windSpeed: Double = 0
    var pressureMm: Int = 0
    var condition: String = ""
    var conditionCode: String = ""
    
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
        self.temp = weatherdata.fact.temp
        self.feelsLike = weatherdata.fact.feelsLike
        self.tempMin = weatherdata.forecasts.first!.parts.day.tempMin!
        self.tempMax = weatherdata.forecasts.first!.parts.day.tempMax!
        self.windSpeed = weatherdata.fact.windSpeed
        self.pressureMm = weatherdata.fact.pressureMm
        self.condition = weatherdata.fact.condition
        self.conditionCode = weatherdata.fact.icon
    }
    
    init() {    
    }
}
