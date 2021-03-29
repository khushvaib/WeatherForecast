//
//  Locations.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 29/03/21.
//

import Foundation

struct Locations: Codable{
    var locations: [LocationDetails]?
}

struct LocationDetails: Codable{
    var name, lat, long: String?
    init(_ name: String = "",_ lat: String = "",_ long: String = "") {
        self.name = name; self.lat = lat; self.long = long
    }
}
