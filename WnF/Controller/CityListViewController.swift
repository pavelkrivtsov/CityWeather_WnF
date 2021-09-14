//
//  ViewController.swift
//  WnF
//
//  Created by Павел Кривцов on 01.09.2021.
//

import UIKit
import Network


class CityListViewController: UITableViewController {
    
    
    var citiesArray = [Weather]()
    var filtredCityArray = [Weather]()
    var cityNamesArray = ["Москва", "Лондон", "Вашингтон", "Пекин", "Токио",
                          "Сидней", "Кейптаун", "Рио-де-Жанейро", "Бангкок", "Стамбул"]
    let addButtonAction = UIBarButtonItem(systemItem: .add)
    let searchController = UISearchController()
    var networkWeatherManager = NetworkWeatherManager()
    
    var cities: [Weather] {
        isFiltering ? filtredCityArray : citiesArray
    }
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    let titleFont = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let label = UILabel()
        label.font = UIFont(name: "SacramentoPro-Regular", size: 34)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8980392157, green: 0.2156862745, blue: 0.568627451, alpha: 1)
        label.text = "City Weather"
        self.navigationItem.titleView = label
        
        addButtonAction.target = self
        addButtonAction.action = #selector(addNewCityWeather)
        navigationItem.rightBarButtonItem = addButtonAction
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        tableView.register(CityWeahterCell.self, forCellReuseIdentifier: "CityWeahterCell")
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        
        citiesArray = cityNamesArray.map { cityName in
            var weather = Weather()
            weather.name = cityName
            return weather
        }
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if NetworkMonitor.shared.isConnected == false {
            noConnectionAlert()
            view.backgroundColor = .systemRed
        }
    }
    
    func addCities() {
        networkWeatherManager.getCityWeahter(citiesArray: cityNamesArray) { [weak self] index, weather in
            guard let self = self else { return }
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.cityNamesArray[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func addNewCityWeather() {
        let alertController = UIAlertController(title: "Добавьте название города", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            let cities = ["Лангепас","Певек","Магадан"]
            textField.clearButtonMode = .whileEditing
            textField.autocorrectionType = .default
            textField.font = UIFont(name: "AvenirNext-UltraLight", size: 15)
            textField.placeholder = cities.randomElement()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let search = UIAlertAction(title: "Найти", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName.isEmpty == false {
                if self.cityNamesArray.contains(cityName) {
                    let ac = UIAlertController(title: "Город есть в списке",
                                               message: "Попробуйте найти другой город",
                                               preferredStyle: .alert)
                    let cansel = UIAlertAction(title: "Отмена", style: .cancel)
                    ac.addAction(cansel)
                    self.present(ac, animated: true)
                } else {
                    let city = cityName.split(separator: " ").joined(separator: "%20")
                    //
                    self.cityNamesArray.append(city)
                    self.citiesArray.append(Weather())
                    self.addCities()
                }
            }
        }
        alertController.addAction(cancel)
        alertController.addAction(search)
        present(alertController, animated: true)
    }
    
    func noConnectionAlert() {
        let noConnectionAlertController = UIAlertController(title: "Нет соединения с Интернетом",
                                                            message: "Подключитесь к Интернету и попробуйте еще раз",
                                                            preferredStyle: .alert)
        noConnectionAlertController.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        self.present(noConnectionAlertController, animated: true)
    }
    
    
    //    MARK: TableView data sourse, tableView delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeahterCell", for: indexPath) as? CityWeahterCell {
            let weather = cities[indexPath.row]
            cell.configure(from: weather)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = cities[indexPath.row]
        let detailCityWeatherVC = DetailCityWeatherVC()
        detailCityWeatherVC.weatherModel = weather
        self.navigationController?.pushViewController(detailCityWeatherVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            let city = self.cities[indexPath.row].name
            self.cityNamesArray = self.cityNamesArray.filter { $0 != city }
            self.citiesArray = self.citiesArray.filter { $0.name != city }
            self.filtredCityArray = self.filtredCityArray.filter { $0.name != city }
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipe
    }
}


// MARK: Search Results Updating

extension CityListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filtredCityArray = citiesArray.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
}
