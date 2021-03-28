//
//  AddLocationViewController.swift
//  WeatherForecast
//
//  Created by Vaibhav Sharma on 27/03/21.
//

import UIKit
import MapKit

protocol AddDesiredLocation {
    func addLocation(loc: LocationDetails)
}

class AddLocationViewController: RootViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    let latitude = 40.730610
    let longitude =  -73.935242
    var coordinates = CLLocationCoordinate2DMake(40.730610, -73.935242)
    var delegate: AddDesiredLocation?
    var location: LocationDetails?
    var addBarBtn: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle("Add Location")
        self.addBackButton()
        addBarBtn?.isEnabled = false
        addBarBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addLocation(_:)))
        self.navigationItem.rightBarButtonItem = self.addBarBtn
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let touchDown = UILongPressGestureRecognizer(target: self, action: #selector(addPinOnTap(longGesture:)))
        touchDown.minimumPressDuration = 0.3
        mapView.addGestureRecognizer(touchDown)
        self.startLocationServices()
    }
    
    @objc func addLocation(_ sender: UIBarButtonItem){
        delegate?.addLocation(loc: self.location!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addPinOnTap(longGesture: UIGestureRecognizer) {
        if longGesture.state == .began {
            // clear mapview
            self.clearMapView()
            
            let touchPoint = longGesture.location(in: mapView)
            let wayCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)
            
            self.addAnnotation(location: location.coordinate)
            self.coordinates = location.coordinate
            self.getAddressFromLatLon(latitude: "\(location.coordinate.latitude)", longitude: "\(location.coordinate.longitude)") { (name) in
                print("####", name)
                self.location = LocationDetails(name, "\(location.coordinate.latitude)", "\(location.coordinate.longitude)")
                self.addBarBtn?.isEnabled = true
            }
        }else if longGesture.state == .ended{
            print("touch ended")
        }
        
    }
    
    // custom methods
    func addAnnotation(location: CLLocationCoordinate2D) {
        let annotation = MapAnnotation.init(coordinate: location)
        self.mapView.addAnnotation(annotation)
    }
    
    func clearMapView(){
        for annotation in self.mapView.annotations {self.mapView.removeAnnotation(annotation)   }
    }
    

}

//MARK:- CLLocation delegates and methods
extension AddLocationViewController: CLLocationManagerDelegate{
    func startLocationServices(){
        self.configureLocationManager()
        locationManager.delegate = self
    }
    
    func configureLocationManager(){
        /*if((locationManager) != nil)
        {
            locationManager.stopMonitoringSignificantLocationChanges()
            locationManager.delegate = nil
            locationManager = nil
        }*/
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.activityType = CLActivityType.otherNavigation
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("lat: ", locations.last?.coordinate.latitude ?? 0.0, NSDate().timeIntervalSince1970)
        print("long: ", locations.last?.coordinate.longitude ?? 0.0, NSDate().timeIntervalSince1970)
        if let location = locations.last{
            self.zoom(lat: location.coordinate.latitude, long: location.coordinate.longitude, inMeters: 4500)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func zoom(lat: Double, long: Double, inMeters: Double){
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), latitudinalMeters: inMeters, longitudinalMeters:inMeters)
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    
    func getAddressFromLatLon(latitude: String, longitude: String, callback: @escaping (String) -> Void) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(latitude)")!
            let lon: Double = Double("\(longitude)")!
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks as [CLPlacemark]?

                    if pm?.count ?? 0 > 0 {
                        let pm = placemarks![0]
                        //print(pm.country as Any)
                        //print(pm.locality as Any)
                        print(pm.subLocality as Any)
                        print(pm.thoroughfare as Any)
                        print(pm.postalCode as Any)
                        print(pm.subThoroughfare as Any)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }
                        
                        
                        print(addressString)
                        callback(pm.locality ?? "")
                  }
            })

        }
    
    
}

struct AddLocation {
    var name: String
    var lat: String
    var long: String
}
