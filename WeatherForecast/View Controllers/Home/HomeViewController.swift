//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Vaibhav on 26/03/21.
//

import UIKit

class HomeViewController: RootViewController {

    @IBOutlet weak var bookmrkTableView: UITableView!
    var data: Locations?
    var weatherData: WeatherData?
    var cellIdentifire = "LocationsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle("Weather Forecast")
        self.view.backgroundColor  = UIColor.init(hex: "627e75")
        
        // registering tableview cell
        bookmrkTableView.registerCellNib(nibName: cellIdentifire)
        //
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "help"), style: .plain, target: self, action: #selector(helpAction(_:)))
        
        // getting data initially
        self.loadJson(fileName: LOCATIONS_JSON) { (response: Locations?, status) in
            if status{
                self.data = response
            }
        }
            
        // Do any additional setup after loading the view.
    }
    
    @objc func helpAction(_ sender: UIBarButtonItem){
        print("helpAction")
    }
    
}

//MARK:- Tableview delegate and datasource methods
extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as? LocationsCell
        cell?.nameLbl.text = self.data?.locations?[indexPath.row].name ?? ""
        cell?.selectionStyle = .default
        return cell!
    }
    
    
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextView = CityViewController(nibName: "CityViewController", bundle: nil)
        nextView.data = self.data?.locations![indexPath.row] ?? LocationDetails()
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

extension HomeViewController{
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UINib(nibName: "FooterView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! FooterView
        footerView.backgroundColor = UIColor.init(hex: AppColors.bg_color.rawValue)
        footerView.addBtn.addTarget(self, action: #selector(addAction(_ :)), for: .touchUpInside)
        return footerView
    }
    
    @objc func addAction(_ sender: UIButton){
        let nextView = AddLocationViewController(nibName: "AddLocationViewController", bundle: nil)
        nextView.delegate = self
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

//MARK:- Adding desired location
extension HomeViewController: AddDesiredLocation{
    func addLocation(loc: LocationDetails) {
        self.data?.locations?.append(loc)
        bookmrkTableView.reloadData()
    }
}

struct Locations: Codable{
    var locations: [LocationDetails]?
}

struct LocationDetails: Codable{
    var name, lat, long: String?
    init(_ name: String = "",_ lat: String = "",_ long: String = "") {
        self.name = name; self.lat = lat; self.long = long
    }
}
