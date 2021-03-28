//
//  Constants.swift
//  CodeRound
//
//  Created by Vaibhav on 10/01/20.
//  Copyright © 2020 Vaibhav. All rights reserved.
//

import Foundation
import UIKit

let AppName = Bundle.main.infoDictionary![String(kCFBundleNameKey)]
let API_URL = "https://itunes.apple.com/search?term=Michael+jackson"
typealias TableViewMethods = UITableViewDelegate & UITableViewDataSource

// files
let LOCATIONS_JSON = "Locations"

enum AppColors: String{
    case  bg_color = "627e75"
    case  fg_color = "e9c429"
}
