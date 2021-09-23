//
//  ViewController.swift
//  Clima
//
//  Created by Giovanna Rodrigues on 21/09/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, WeatherMenagerDelegate{

    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManeger = WeatherMenager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManeger.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManeger.fetchWeather(city: city)
        }
        searchTextField.text = ""
    }
    func didUpdateWeather(_ weatherManager : WeatherMenager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.stringTemp
            self.cityLabel.text = weather.city
            self.climaImageView.image = UIImage(systemName: weather.condition)
        }
    }
    func weatherManagerDidFail(error: Error) {
        print(error)
    }
    
}

