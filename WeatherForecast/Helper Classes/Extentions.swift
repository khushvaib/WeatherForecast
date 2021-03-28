//
//  Extentions.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 27/03/21.
//

import UIKit
//import Foundation


extension UIViewController{
    
    typealias codable = Codable & Decodable
    func loadJson<Generic: codable>(fileName: String, completion: @escaping (Generic?, Bool)->Void){
        
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let obj = try? decoder.decode(Generic.self, from: data)
        else {
            print("Error: ", errno)
            /**Unrelated key inside the data model doesnt parse, gives error*/   //return nil
            completion(nil, false)
            return
        }
//        return obj
        completion(obj, true)
    }
    
    func setTitle(_ title: String = "......"){
        self.navigationItem.title = title
    }
}


extension UITableView {
    
    public func initilization(_ cellName: String,_ rowHight : CGFloat = 80) {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = rowHight
        self.registerCellNib(nibName: cellName)
        self.tableFooterView = UIView()
    }
    
    func registerCellNib(nibName:String?){
        if let nibName = nibName {
            self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
    
    }
    
    
}

