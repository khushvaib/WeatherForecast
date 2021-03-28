//
//  TempCell.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 28/03/21.
//

import UIKit

class TempCell: UITableViewCell {
    
    @IBOutlet weak var tempLbl          : UILabel!
    @IBOutlet weak var unit             : UILabel!
    var viewModelObj = CityViewModel()
    var weatherData: WeatherData?
    var tempUnitInCelsius = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: WeatherData){
        self.weatherData = data
        self.tempLbl.text = "\(self.viewModelObj.kelvin_to_celsius(kelvins: data.main?.temp ?? 0.0).roundTo(places: 2))"
        
    }
    
    @IBAction func changTempUnit(_ sender: UIButton){
        self.tempLbl.text = tempUnitInCelsius ? "\(self.viewModelObj.kelvin_to_fahrenheit(kelvins: self.weatherData?.main?.temp ?? 0.0).roundTo(places: 2))" : "\(self.viewModelObj.kelvin_to_celsius(kelvins: self.weatherData?.main?.temp ?? 0.0).roundTo(places: 2))"
        self.unit.text = tempUnitInCelsius ? "F" : "C"
        self.tempUnitInCelsius = tempUnitInCelsius ? false : true
    }
    
}
