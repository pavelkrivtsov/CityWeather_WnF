//
//  CityWeahterCell.swift
//  WnF
//
//  Created by Павел Кривцов on 05.09.2021.
//

import UIKit

class CityWeahterCell: UITableViewCell {
    
    var mainStack = UIStackView()
    var verticalStack = UIStackView()
    var cityName = UILabel()
    var cityDiscriptionWeather = UILabel()
    var horizontalStack = UIStackView()
    var weatherTemperature = UILabel()
    var iconWeatherDiscription = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        mainStack.addArrangedSubview(verticalStack)
        mainStack.addArrangedSubview(horizontalStack)
        mainStack.spacing = 5

        verticalStack.axis = .vertical
        verticalStack.distribution = .fillProportionally
        verticalStack.addArrangedSubview(cityName)
        verticalStack.addArrangedSubview(cityDiscriptionWeather)
        
        cityName.backgroundColor = .magenta
        cityName.text = "Название города"
        cityName.font = UIFont(name: "AvenirNext-Medium", size: 20)
        cityName.textAlignment = .center
        cityDiscriptionWeather.backgroundColor = .cyan
        cityDiscriptionWeather.text = "Описание погоды"
        cityDiscriptionWeather.font = UIFont(name: "AvenirNext-Regular", size: 15)
        cityDiscriptionWeather.textAlignment = .center
                
        horizontalStack.axis = .horizontal
        horizontalStack.addArrangedSubview(iconWeatherDiscription)
        horizontalStack.addArrangedSubview(weatherTemperature)
        
        weatherTemperature.text = "°C"
        weatherTemperature.textAlignment = .center
        weatherTemperature.backgroundColor = .orange
        weatherTemperature.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weatherTemperature.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        iconWeatherDiscription.backgroundColor = .green
        iconWeatherDiscription.image = UIImage(systemName: "smoke.fill")
        iconWeatherDiscription.contentMode = .scaleAspectFit
        iconWeatherDiscription.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iconWeatherDiscription.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(from weather: Weather) {
        self.cityName.text = weather.name
        self.cityDiscriptionWeather.text = weather.conditionString
        self.weatherTemperature.text = "\(weather.temperature)°C"
        self.iconWeatherDiscription.image = UIImage(named: weather.conditionCode)
    }
}
