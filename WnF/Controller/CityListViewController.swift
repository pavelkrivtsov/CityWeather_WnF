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
    var filtredCityArray = [Weather]()
    var cityNamesArray = ["Москва", "Лондон", "Вашингтон", "Пекин", "Токио",
                          "Сидней", "Кейптаун", "Рио-де-Жанейро", "Бангкок", "Стамбул"]
    let addButtonAction = UIBarButtonItem(systemItem: .add)
    let searchController = UISearchController()
    var searchBarisEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarisEmpty
    }
    
    let titleFont = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.font = UIFont(name: "SacramentoProSlim", size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "City Weather"
        self.navigationItem.titleView = label
        
        addButtonAction.target = self
        addButtonAction.action = #selector(addNewCityWeather)
        navigationItem.rightBarButtonItem = addButtonAction
        
        tableView.register(CityWeahterCell.self, forCellReuseIdentifier: "CityWeahterCell")
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: cityNamesArray.count)
        }
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
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
                let city = cityName.split(separator: " ").joined(separator: "%20")
                
                self.cityNamesArray.append(city)
                self.citiesArray.append(self.emptyCity)
                self.addCities()
            }
        }
        alertController.addAction(cancel)
        alertController.addAction(search)
        present(alertController, animated: true, completion: nil)
    }
    
    //    MARK: TableView DataSource and Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsInSection = isFiltering ? filtredCityArray.count : citiesArray.count
        return rowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeahterCell", for: indexPath) as? CityWeahterCell {
            let weather = isFiltering ? filtredCityArray[indexPath.row] : citiesArray[indexPath.row]
            cell.configure(from: weather)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = isFiltering ? filtredCityArray[indexPath.row] : citiesArray[indexPath.row]
        let detailCityWeatherVC = DetailCityWeatherVC()
        detailCityWeatherVC.weatherModel = weather
        self.navigationController?.pushViewController(detailCityWeatherVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            let city = self.cityNamesArray[indexPath.row]
            if let index = self.cityNamesArray.firstIndex(of: city) {
                if self.isFiltering {
                    self.filtredCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
            }
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipe
    }
}

extension CityListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filtredCityArray = citiesArray.filter({
            $0.name.contains(searchText)
        })
        tableView.reloadData()
    }
}
