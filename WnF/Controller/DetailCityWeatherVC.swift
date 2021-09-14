//
//  DetailCityWeatherVC.swift
//  WnF
//
//  Created by Павел Кривцов on 05.09.2021.
//

import UIKit

class DetailCityWeatherVC: UIViewController {
    
    let mainWeatherView = UIView()
    let newTitleFont = UILabel()
    let weatherIcon = UIImageView()
    var temperature = UILabel()
    let feelsLikeTemperature = UILabel()
    let weatherDescription = UILabel()
    let horizontalView = UIView()
    let horizontalStack = UIStackView()
    let pressure = UIImageView()
    let pressureValue = UILabel()
    let pressureStack = UIStackView()
    let humidity = UIImageView()
    let humidityValue = UILabel()
    let humidityStack = UIStackView()
    let windSpeed = UIImageView()
    let windSpeedValue = UILabel()
    let windSpeedStack = UIStackView()
    let backgroundImage = UIImageView(image: UIImage(named: "background"))
    var weatherModel: Weather!
    let constraintSize = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIBOutlets()
        setupConstraints()
        setupDetailCityWeather()
    }
    
    func setupIBOutlets() {
        backgroundImage.contentMode = .scaleAspectFill
        
        mainWeatherView.backgroundColor = .systemGray5
        mainWeatherView.layer.cornerRadius = 25
        
        weatherIcon.contentMode = .scaleAspectFit
        
        temperature.text = "°C"
        temperature.adjustsFontSizeToFitWidth = true
        temperature.numberOfLines = 0
        temperature.font = UIFont(name: "AvenirNext-Medium", size: 65)
        temperature.textColor = UIColor(named: "TextColor")
        
        feelsLikeTemperature.text = "Ощущается как"
        feelsLikeTemperature.adjustsFontSizeToFitWidth = true
        feelsLikeTemperature.numberOfLines = 0
        feelsLikeTemperature.font = UIFont(name: "AvenirNext-Regular", size: 15)
        feelsLikeTemperature.textColor = UIColor(named: "TextColor")
        
        weatherDescription.text = "Описание погоды"
        weatherDescription.adjustsFontSizeToFitWidth = true
        weatherDescription.numberOfLines = 0
        weatherDescription.font = UIFont(name: "AvenirNext-Medium", size: 20)
        weatherDescription.textColor = UIColor(named: "TextColor")
        
        horizontalView.backgroundColor = .systemGray5
        horizontalView.layer.cornerRadius = 25
        horizontalView.clipsToBounds = true
        
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.addArrangedSubview(pressureStack)
        horizontalStack.addArrangedSubview(humidityStack)
        horizontalStack.addArrangedSubview(windSpeedStack)
        
        pressureStack.axis = .vertical
        pressureStack.spacing = 5
        pressureStack.alignment = .center
        pressureStack.distribution = .fillEqually
        pressureStack.addArrangedSubview(pressure)
        pressureStack.addArrangedSubview(pressureValue)
        pressure.image = UIImage(systemName: "barometer")
        pressure.contentMode = .scaleAspectFill
        pressureValue.text = "мм"
        pressureValue.adjustsFontSizeToFitWidth = true
        pressureValue.font = UIFont(name: "AvenirNext-Regular", size: 20)
        
        humidityStack.axis = .vertical
        humidityStack.spacing = 5
        humidityStack.alignment = .center
        humidityStack.distribution = .fillEqually
        humidityStack.addArrangedSubview(humidity)
        humidityStack.addArrangedSubview(humidityValue)
        humidity.image = UIImage(systemName: "drop")
        humidity.contentMode = .scaleAspectFill
        humidityValue.text = "%"
        humidityValue.adjustsFontSizeToFitWidth = true
        humidityValue.font = UIFont(name: "AvenirNext-Regular", size: 20)
        
        windSpeedStack.axis = .vertical
        windSpeedStack.spacing = 5
        windSpeedStack.alignment = .center
        windSpeedStack.distribution = .fillEqually
        windSpeedStack.addArrangedSubview(windSpeed)
        windSpeedStack.addArrangedSubview(windSpeedValue)
        windSpeed.image = UIImage(systemName: "wind")
        windSpeed.contentMode = .scaleAspectFill
        windSpeedValue.text = "м/с"
        windSpeedValue.adjustsFontSizeToFitWidth = true
        windSpeedValue.font = UIFont(name: "AvenirNext-Regular", size: 20)
    }
    
    func setupConstraints() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        view.addSubview(mainWeatherView)
        mainWeatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(constraintSize)),
            mainWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-constraintSize)),
            mainWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(constraintSize)),
            mainWeatherView.heightAnchor.constraint(equalToConstant: CGFloat(constraintSize * 10))
        ])
        
        mainWeatherView.addSubview(weatherIcon)
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherIcon.topAnchor.constraint(equalTo: mainWeatherView.topAnchor, constant: CGFloat(constraintSize)),
            weatherIcon.bottomAnchor.constraint(equalTo: mainWeatherView.bottomAnchor, constant: CGFloat(-constraintSize)),
            weatherIcon.leadingAnchor.constraint(equalTo: mainWeatherView.leadingAnchor, constant: CGFloat(constraintSize)),
            weatherIcon.trailingAnchor.constraint(equalTo: mainWeatherView.centerXAnchor, constant: CGFloat(-constraintSize / 2))
        ])
        
        mainWeatherView.addSubview(temperature)
        temperature.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperature.leadingAnchor.constraint(equalTo: mainWeatherView.centerXAnchor, constant: CGFloat(constraintSize / 2)),
            temperature.trailingAnchor.constraint(equalTo: mainWeatherView.trailingAnchor, constant: CGFloat(-constraintSize)),
            temperature.bottomAnchor.constraint(equalTo: mainWeatherView.centerYAnchor),
            temperature.topAnchor.constraint(equalTo: mainWeatherView.topAnchor, constant: CGFloat(constraintSize))
        ])
        
        mainWeatherView.addSubview(feelsLikeTemperature)
        feelsLikeTemperature.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feelsLikeTemperature.leadingAnchor.constraint(equalTo: temperature.leadingAnchor),
            feelsLikeTemperature.trailingAnchor.constraint(equalTo: temperature.trailingAnchor),
            feelsLikeTemperature.topAnchor.constraint(equalTo: mainWeatherView.centerYAnchor),
            feelsLikeTemperature.heightAnchor.constraint(equalToConstant: CGFloat(constraintSize))
        ])
        
        mainWeatherView.addSubview(weatherDescription)
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherDescription.leadingAnchor.constraint(equalTo: feelsLikeTemperature.leadingAnchor),
            weatherDescription.trailingAnchor.constraint(equalTo: feelsLikeTemperature.trailingAnchor),
            weatherDescription.bottomAnchor.constraint(equalTo: mainWeatherView.bottomAnchor, constant: CGFloat(-constraintSize)),
            weatherDescription.topAnchor.constraint(equalTo: feelsLikeTemperature.bottomAnchor, constant: CGFloat(constraintSize / 2))
        ])
        
        view.addSubview(horizontalView)
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(constraintSize)),
            horizontalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-constraintSize)),
            horizontalView.topAnchor.constraint(equalTo: mainWeatherView.bottomAnchor, constant: CGFloat(constraintSize)),
            horizontalView.heightAnchor.constraint(equalToConstant: CGFloat(constraintSize * 5))
        ])
        
        horizontalView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: horizontalView.topAnchor, constant: CGFloat(constraintSize)),
            horizontalStack.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: CGFloat(-constraintSize)),
            horizontalStack.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor, constant: CGFloat(constraintSize)),
            horizontalStack.trailingAnchor.constraint(equalTo: horizontalView.trailingAnchor, constant: CGFloat(-constraintSize))
        ])
    }
    
    func setupDetailCityWeather() {
        self.temperature.text = "\(weatherModel.temperature)°C"
        self.feelsLikeTemperature.text = "Ощущается как \(weatherModel.feelsLike)°C"
        self.weatherDescription.text = weatherModel.conditionString
        self.weatherIcon.image = UIImage(systemName: weatherModel.conditionIcon)
        self.pressureValue.text = "\(weatherModel.pressureMm)мм"
        self.humidityValue.text = "\(weatherModel.humidity)%"
        self.windSpeedValue.text = "\(weatherModel.windSpeed)м/c"
        
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 25)
        label.textAlignment = .center
        label.text = weatherModel.name
        self.navigationItem.titleView = label
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
        }
    }
}
