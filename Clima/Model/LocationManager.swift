//
//  LocationManager.swift
//  Clima
//
//  Created by Анастасия Бегинина on 16.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation



func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
) {
    if let location = locations.first {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        // Handle location update
    }
}


func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
) {
    // Handle failure to get a user’s location
}

