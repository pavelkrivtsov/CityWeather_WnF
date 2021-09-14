//
//  CityWeahterCell.swift
//  WnF
//
//  Created by Павел Кривцов on 05.09.2021.
//

import UIKit

class CityWeahterCell: UITableViewCell {
    
    var mainStack = UIStackView()
    var cityName = UILabel()
    var cityDiscriptionWeather = UILabel()
    var weatherTemperature = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIBOutlets()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIBOutlets() {
        mainStack.spacing = 5
        mainStack.axis = .horizontal
        mainStack.distribution = .fill
        
        cityName.text = "Название города"
        cityName.font = UIFont(name: "AvenirNext-Medium", size: 20)
        cityName.textAlignment = .left
        cityName.numberOfLines = 0
        
        cityDiscriptionWeather.text = "Описание погоды"
        cityDiscriptionWeather.font = UIFont(name: "AvenirNext-UltraLight", size: 15)
        cityDiscriptionWeather.numberOfLines = 0
        cityDiscriptionWeather.textAlignment = .right
        
        weatherTemperature.text = "°C"
        weatherTemperature.font = UIFont(name: "AvenirNext-Regular", size: 20)
        weatherTemperature.textAlignment = .center
    }
    
    func setupConstraints() {
        self.contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(cityName)
        mainStack.addArrangedSubview(cityDiscriptionWeather)
        mainStack.addArrangedSubview(weatherTemperature)
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cityDiscriptionWeather.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            weatherTemperature.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    func configure(from weather: Weather) {
        self.cityName.text = weather.name
        self.cityDiscriptionWeather.text = weather.conditionString
        self.weatherTemperature.text = "\(weather.temperature)°C"
    }
}

