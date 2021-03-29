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
    var cellIdentifire = "LocationsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle("Weather Forecast")
        
        // registering tableview cell
        bookmrkTableView.registerCellNib(nibName: cellIdentifire)
        //
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "help"), style: .plain, target: self, action: #selector(helpAction(_:)))
        
        // getting data initially
        self.data = self.loadJson(fileName: LOCATIONS_JSON)
    }
    
    @objc func helpAction(_ sender: UIBarButtonItem){
        print("helpAction")
        let nextView = HelpViewController(nibName: "HelpViewController", bundle: nil)
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
}

//MARK:- Tableview datasource methods
extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as? LocationsCell
        cell?.setData(data: self.data?.locations?[indexPath.row] ?? LocationDetails())
        cell?.selectionStyle = .default
        return cell!
    }
    
}

//MARK:- Tableview delegate methods
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextView = CityViewController(nibName: "CityViewController", bundle: nil)
        nextView.data = self.data?.locations![indexPath.row] ?? LocationDetails()
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.data?.locations?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK:- Tableview footer section
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
        nextView.prev_loc = self.data // sending bookedmarked location to authenticate newly adding locations
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
