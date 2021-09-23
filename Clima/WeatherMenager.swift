//
//  WeatherMenager.swift
//  Clima
//
//  Created by Giovanna Rodrigues on 22/09/21.
//

import Foundation

struct WeatherMenager {
    let generalUrl = "https://api.openweathermap.org/data/2.5/weather?appid=c27892cd89e32e510d4006add996f93c&units=metric"
    
    func fetchWeather(city : String){
        let cityUrl = "\(generalUrl)&q=\(city)"
        requestData(cityUrl)
    }
    
    func requestData(_ cityUrl : String){
        if let url = URL(string: cityUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let rawData = data {
                    parseJson(data: rawData)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(data : Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let weatherModel = WeatherModel(conditionId: id, city: cityName, temperature: temp)
            print("City: \(weatherModel.city)")
            print("Temp: \(weatherModel.temperature)")
            print("Condition: \(weatherModel.condition)")
        } catch {
            print("Error")
        }
    }
    
}
