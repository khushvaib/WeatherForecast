//
//  MapAnnotation.swift
//  AppleMapDemo
//
//  Created by Vaibhav on 05/12/20.
//



import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {

    //MKAnnotation protocol
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var subtitle: String?
    
    //Initializer
    init(coordinate: CLLocationCoordinate2D,_ title: String = "", _ subtitle: String = "") {
        self.coordinate     = coordinate
        self.title          = title
        self.subtitle       = subtitle
        
        super.init()
    }
}
