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
            print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            let condition = getCondition(id: id)
            print("condition: \(condition)")
        } catch {
            print("Error")
        }
    }
    
    func getCondition(id : Int) -> String{
        switch id {
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
