//
//  ViewController.swift
//  Clima
//
//  Created by Giovanna Rodrigues on 21/09/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{

    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate
extension ViewController : UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(city: city)
        }
        searchTextField.text = ""
    }
}
//MARK: - WeatherManagerDelegate
extension ViewController : WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel){
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

//MARK: - CLLocationManagerDelegate
extension ViewController : CLLocationManagerDelegate{
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, long: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error: \(error)")
    }
    
}
