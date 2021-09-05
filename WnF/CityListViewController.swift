//
//  ViewController.swift
//  WnF
//
//  Created by Павел Кривцов on 01.09.2021.
//

import UIKit


class CityListViewController: UITableViewController {
    
    let emptyCity = Weather()
    var citiesArray = [Weather]()
    let cityNamesArray = ["Москва", "Лондон", "Вашингтон", "Пекин", "Токио",
                          "Сидней", "Кейптаун", "Рио-де-Жанейро", "Таиланд", "Стамбул"]
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WnF"
        
        tableView.register(CityWeahterCell.self, forCellReuseIdentifier: "CityWeahterCell")
        tableView.tableFooterView = UIView()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: cityNamesArray.count)
        }
        addCities()
    }
    
    func addCities() {
        getCityWeahter(citiesArray: cityNamesArray) { index, weather in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.cityNamesArray[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //    MARK: TableView DataSource and Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeahterCell", for: indexPath) as? CityWeahterCell {
            let weather = citiesArray[indexPath.row]
            cell.configure(from: weather)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = citiesArray[indexPath.row]
        let detailCityWeatherVC = DetailCityWeatherVC()
        detailCityWeatherVC.weatherModel = weather
        self.navigationController?.pushViewController(detailCityWeatherVC, animated: true)
    }
    
}

