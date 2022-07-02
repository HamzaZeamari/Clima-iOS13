//
// Created by Mohamed Zeamari on 02/07/2022.
// Copyright (c) 2022 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel{
    let conditionId: Int
    let cityName : String
    let temperature : Double


    init(conditionId: Int, cityName: String, temperature: Double) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
    }
    var conditionName: String{
        switch(conditionId){
        case (200...232): return "cloud.bolt.rain"
        case (300...321): return "cloud.drizzle"
        case (500...531): return "cloud.rain"
        case (600...622): return "cloud.snow"
        case (701...781): return "humidity"
        case (800):       return "sun.min"
        case (801...804): return "cloud"
        default:          return "sun.max"
        }
    }
    var temperatureString : String{
        return String(format: "%.1f", temperature)
    }

}