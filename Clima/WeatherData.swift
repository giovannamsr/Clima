//
//  WeatherData.swift
//  Clima
//
//  Created by Giovanna Rodrigues on 23/09/21.
//

import Foundation

struct WeatherData : Decodable {
    let weather : [Weather]
    let main : Main
    let name : String
}
struct Weather : Decodable{
    let id : Int
}
struct Main : Decodable{
    let temp : Double
}


