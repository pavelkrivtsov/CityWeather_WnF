//
//  ViewController.swift
//  WnF
//
//  Created by Павел Кривцов on 01.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.fetchWeather()
        networkWeatherManager.omCompletion = { weather in
            print(weather)
        }
    }
    
}

