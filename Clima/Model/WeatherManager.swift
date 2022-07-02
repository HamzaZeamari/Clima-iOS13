//
//  WeatherManager.swift
//  Clima
//
//  Created by Mohamed Zeamari on 01/07/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1ce2ff04101d4032e16064626107c0ea&units=metric"
    var delegate : WeatherManagerDelegate?
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String){
        // 1 : Create URL
        if let url = URL(string: urlString){
            // 2 : Create URLSession
            let session = URLSession(configuration: .default)
            // 3 : Give the session a Task
            let task = session.dataTask(with: url) { data, response, error in
                if(error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJson(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self,weather : weather)
                    }
                }
            }
            // 4 : Start the task
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp

            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }

    
}
