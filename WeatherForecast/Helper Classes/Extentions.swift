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
    func loadJson<Generic: codable>(fileName: String) -> Generic?{
        
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let obj = try? decoder.decode(Generic.self, from: data)
        else {
            print("Error: ", errno)
            /**Unrelated key inside the data model doesnt parse, gives error*/   //return nil
//            completion(nil, false)
            return nil
        }
        return obj
//        completion(obj, true)
    }
    
    func setTitle(_ title: String = "......"){
        self.navigationItem.title = title
    }
}

public extension UIColor {
    convenience init(hex: String,alpha:CGFloat = 1) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
    class func colorWithHexString (hex:String) -> UIColor {
        
        var hexWithoutSymbol:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (hexWithoutSymbol.hasPrefix("#")) {
            hexWithoutSymbol = (hexWithoutSymbol as NSString).substring(from: 1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            r = 0
            g = 0
            b = 0
            break;
        }
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
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

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

