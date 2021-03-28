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
