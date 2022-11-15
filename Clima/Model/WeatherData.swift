//
//  WeatherData.swift
//  Clima
//
//  Created by Анастасия Бегинина on 15.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Int
    let sys: Sys
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable{
    let id: Int
    let main: String
    let description: String
}

struct Sys: Codable{
    let sunset: Int
    let sunrise: Int
}
