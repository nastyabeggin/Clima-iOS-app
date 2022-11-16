//
//  WeatherManager.swift
//  Clima
//
//  Created by Анастасия Бегинина on 15.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    var cityNameValue: String;
    let weatherURL  = "https://api.openweathermap.org/data/2.5/weather?&appid=8721a08c75b1c6e50506f932283c14aa&units=metric&lang=ru"
    var delegate: WeatherManagerDelegate?
    
    mutating func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    
    
    mutating func fetchWeather(cityName: String){
        cityNameValue = cityName
        let urlString = "\(weatherURL)&q=\(cityName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        performRequest(urlString: urlString!)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weatherModel = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weatherModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let weatherDescription = decodedData.weather[0].description
            print(weatherDescription)
            var isItDay = true;
            if decodedData.dt > decodedData.sys.sunset{
                isItDay = false
            }
            
            let weatherModel = WeatherModel(conditionId: id, cityName: decodedData.name, temperature: temp, weatherDescription: weatherDescription, dayTime: isItDay)
            
            return weatherModel
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
