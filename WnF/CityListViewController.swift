//
//  ViewController.swift
//  WnF
//
//  Created by Павел Кривцов on 01.09.2021.
//

import UIKit


class ViewController: UIViewController {
    
    let emptyCity = Weather()
    var citiesArray = [Weather]()
    let cityNamesArray = ["Москва", "Лондон", "Вашингтон", "Пекин"]
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: cityNamesArray.count)
        }
        addCities()
    }
    
    func addCities() {
        getCityWeahter(citiesArray: cityNamesArray) { index, weather in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.cityNamesArray[index]
            print(self.citiesArray)
        }
    }
    
    
}

