//
//  CityViewModel.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 28/03/21.
//

import Foundation
import UIKit

class CityViewModel{
    
    // unit conversion methods
    func kelvin_to_celsius(kelvins: Double) -> Double{
        let celsius = kelvins - 273.15
        return celsius
    }
    
    func kelvin_to_fahrenheit(kelvins: Double) -> Double{
        let fahren = (kelvins - 273.15) * 9/5 + 32
        return fahren
    }
    
    func miles_per_hour(meterPerSec: Double) -> Double{
        return meterPerSec * 2.237
    }
}
