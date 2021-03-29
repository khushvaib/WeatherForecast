//
//  LocationsCell.swift
//  WeatherForecast
//
//  Created by Vaibhav on 26/03/21.
//

import UIKit

class LocationsCell: UITableViewCell {

    @IBOutlet weak var cityNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: LocationDetails){
        self.cityNameLbl.text = data.name ?? ""
    }
    
}
