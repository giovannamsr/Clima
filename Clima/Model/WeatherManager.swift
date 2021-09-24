//
//  WeatherMenager.swift
//  Clima
//
//  Created by Giovanna Rodrigues on 22/09/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel)
    func weatherManagerDidFail(error : Error)
}

struct WeatherManager {
    let generalUrl = "https://api.openweathermap.org/data/2.5/weather?appid=c27892cd89e32e510d4006add996f93c&units=metric"
    
    func fetchWeather(city : String){
        var fixedCity = city.folding(options: .diacriticInsensitive, locale: .current)
        fixedCity = String(fixedCity.map{$0 == " " ? "+" : $0})
        let cityUrl = "\(generalUrl)&q=\(fixedCity)"
        requestData(cityUrl)
    }
    func fetchWeather(lat : CLLocationDegrees, long: CLLocationDegrees){
        let coordinatesUrl = "\(generalUrl)&lat=\(lat)&lon=\(long)"
        requestData(coordinatesUrl)
    }
    
    
    var delegate : WeatherManagerDelegate?
    
    func requestData(_ cityUrl : String){
        if let url = URL(string: cityUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.weatherManagerDidFail(error: error!)
                    return
                }
                if let rawData = data {
                    if let weather = parseJson(data: rawData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(data : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            return WeatherModel(conditionId: id, city: cityName, temperature: temp)
        } catch {
            delegate?.weatherManagerDidFail(error: error)
            return nil
        }
    }
    
}
