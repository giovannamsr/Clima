//
//  WeatherModel.swift
//  Clima
//
//  Created by Giovanna Rodrigues on 23/09/21.
//

import Foundation

struct WeatherModel {
    let conditionId : Int
    let city : String
    let temperature : Double
    var stringTemp : String {
        return String(format: "%.1f", temperature)
    }
    var condition : String {
        switch conditionId {
        case 200...202,221,230...232:
            return "cloud.bolt.rain"
        case 210...212:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...602, 615, 616, 620...622:
            return "cloud.snow"
        case 611...613:
            return "cloud.sleet"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
            
        }
        
    }
    
}


