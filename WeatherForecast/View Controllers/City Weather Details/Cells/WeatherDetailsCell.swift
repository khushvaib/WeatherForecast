//
//  WeatherDetailsCell.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 28/03/21.
//

import UIKit

class WeatherDetailsCell: UITableViewCell {

    @IBOutlet weak var windInfo         : UILabel!
    @IBOutlet weak var rainChancesLbl   : UILabel!
    @IBOutlet weak var humidityLbl      : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: WeatherData){
        self.humidityLbl.text = "\(data.main?.humidity ?? 0)%"
        self.rainChancesLbl.text = "\(data.main?.humidity ?? 0)%"
        self.windInfo.text = "\(data.main?.humidity ?? 0)%"
    }
    
}
