//
//  ViewController.swift
//  WnF
//
//  Created by Павел Кривцов on 01.09.2021.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getCityCoordinates(ofCity city: String,
                            onCompletion: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { placemark, error in
            onCompletion(placemark?.first?.location?.coordinate, error)
        }
    }
}

