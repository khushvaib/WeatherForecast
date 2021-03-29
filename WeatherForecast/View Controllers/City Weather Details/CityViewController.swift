//
//  CityViewController.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 27/03/21.
//

import UIKit

class CityViewController: RootViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    
    
    var weatherData: WeatherData?
    var data = LocationDetails()
    let tempCellId = "TempCell"
    let weatherDetailsCellId = "WeatherDetailsCell"
    let fiveDaysDataCellId = "FiveDaysDetailsCell"
    
    var fiveDayData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitle(data.name ?? "")
        self.addBackButton()
        let apiUrl = "\(base_url)lat=\(data.lat ?? "")&lon=\(data.long ?? "")&appid=\(api_key)"
        
        // http://api.openweathermap.org/data/2.5/forecast/daily?q=jaipur&cnt=7&appid=fae7190d7e6433ec3a45285ffcf55c86
        
//        http://api.openweathermap.org/data/2.5/forecast?lat=22.572645&lon=88.363892&cnt=5&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric
        
        //http://api.openweathermap.org/data/2.5/forecast?lat=22.572645&lon=88.363892&cnt=5&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric
        
        // regsitering tableview cell
        self.registerCells()
       /* Services.getWeatherData(url: getCityDataUrl) { (response) in
            print(response )
            
            DispatchQueue.main.async {
                self.weatherData = response
                self.detailsTableView.reloadData()
//                self.getFiveDayData()
            }
            
        }*/
        
        Services.getApiData(url: apiUrl) { (response: WeatherData?) in
            self.weatherData = response!
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
            }
        }
    }
    
    func getFiveDayData(){
        
        Services.getApiData(url: "http://api.openweathermap.org/data/2.5/forecast?lat=22.572645&lon=88.363892&cnt=5&appid=\(api_key)&units=metric") { (response: WeatherDataList?) in
            print(response!)
        }
    }
    
    // register cells
    func registerCells(){
        detailsTableView.registerCellNib(nibName: tempCellId)
        detailsTableView.registerCellNib(nibName: weatherDetailsCellId)
        detailsTableView.registerCellNib(nibName: fiveDaysDataCellId)
    }

}


//MARK:- Tableview delegate and datasource methods
extension CityViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: tempCellId) as? TempCell
            cell?.setData(data: self.weatherData ?? WeatherData())
            cell?.selectionStyle = .default
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: weatherDetailsCellId) as? WeatherDetailsCell
            cell?.setData(data: self.weatherData ?? WeatherData())
            cell?.selectionStyle = .default
            return cell!
        }
        
    }
    
}
