//
//  RootViewController.swift
//  WeatherForecast
//
//  Created by Vaibhav on 26/03/21.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigation()
        // Do any additional setup after loading the view.
    }
    

    func configNavigation(){
        /**
         #627e75     (98,126,117)
        #d2a985     (210,169,133)
        #226ba3     (34,107,163)
        #e9c429     (233,196,41)
        #913639     (145,54,57)
         */
        self.navigationController?.navigationBar.barTintColor = UIColor.init(hex: "627e75")
        //navigation bar configuraiotn settings
        self.navigationController?.navigationBar.isTranslucent = false
        let attrs:[NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 20.0) as Any
        ]
        navigationController?.navigationBar.titleTextAttributes = attrs
        
    }
    
    func addBackButton(){
        self.navigationItem.hidesBackButton = true
        let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        backButton.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        let item = UIBarButtonItem(customView: backButton)
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
    }
    
    @objc func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

