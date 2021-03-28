//
//  CityViewController.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 27/03/21.
//

import UIKit

class CityViewController: RootViewController {

    var data = LocationDetails()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitle("City")
        self.addBackButton()
        let getCityDataUrl = "http://api.openweathermap.org/data/2.5/weather?lat=\(data.lat ?? "")&lon=\(data.long ?? "")&appid=fae7190d7e6433ec3a45285ffcf55c86"
        print(data.lat ?? "")
        print(data.long ?? "")
        // http://api.openweathermap.org/data/2.5/forecast/daily?q=jaipur&cnt=7&appid=fae7190d7e6433ec3a45285ffcf55c86
        
        // by geo cordinates
        //api.openweathermap.org/data/2.5/forecast/daily?lat=22.572645&lon=88.363892&cnt=5&appid=fae7190d7e6433ec3a45285ffcf55c86
        
//        http://api.openweathermap.org/data/2.5/forecast?lat=22.572645&lon=88.363892&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric
        /*Services.postAction(params: ["":""], url: getCityDataUrl) { (response, status) in
            if status{
//                self.weatherData = response!
                //print(response!)
            }
        }*/
        
        Services.getWeatherData(url: getCityDataUrl) { (response) in
            print(response )
        }
        // Do any additional setup after loading the view.
    }

}
