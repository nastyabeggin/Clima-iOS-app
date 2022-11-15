//
//  WeatherModel.swift
//  Clima
//
//  Created by Анастасия Бегинина on 15.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let weatherDescription: String
    let dayTime: Bool
    
    var temperatureString: String{
        return String(Int(temperature))
    }
    
    var conditionName: String {
        switch conditionId{
        case 200...202, 230...232:
            return "cloud.bolt.rain"
        case 203...221:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...610, 617...622:
            return "cloud.snow"
        case 611...616:
            return "cloud.sleet"
        case 700...770:
            return "cloud.fog"
        case 771...781:
            return "tornado"
        case 800:
            if dayTime{
                return "sun.max"
            } else{
                return "moon"
            }
        case 801...810:
            return "clouds"
        default:
            return "clouds"
        }
        
    }
}
