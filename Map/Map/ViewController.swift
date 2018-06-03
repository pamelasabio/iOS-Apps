//
//  ViewController.swift
//  Map
//
//  Created by Pamela on 02/06/2018.
//  Copyright © 2018 Pamela. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get user location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Create the map
        //Go to spire in Dublin city centre
        let latitude: CLLocationDegrees = 53.3499662
        let longitude: CLLocationDegrees = -6.2624647
        //Delta = difference of lat/lng from one side of screen to another
        let latDelta: CLLocationDegrees = 0.05
        let lngDelta: CLLocationDegrees = 0.05
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        //Create annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Spire"
        annotation.subtitle = "The Dublin Spire in O'Connell Street"
        map.addAnnotation(annotation)
        
        //Create gesture recogniser
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(gestureRecognizer:)))
        longPress.minimumPressDuration = 2
        map.addGestureRecognizer(longPress)
    }
    
    @objc func longPressed(gestureRecognizer: UIGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: self.map)
        let newCoordinate: CLLocationCoordinate2D = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        addMarker(location: newCoordinate)
    }
    
    //get user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var userLocation: CLLocation = locations[0] as! CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lngDelta: CLLocationDegrees = 0.05
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: true)
        addMarker(location: location)
        
    }
    
    func addMarker(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
    
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { (placemarks, error) in
            if error != nil{
                print(error!)
            }else{
                let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark)
                
                var subThoroughfare: String = ""
                if p.subThoroughfare != nil{
                    subThoroughfare = p.subThoroughfare!
                }
                var thoroughfare: String = ""
                if p.thoroughfare != nil{
                    thoroughfare = p.thoroughfare!
                }
                annotation.title = "\(p.name!)"
                annotation.subtitle = "\(subThoroughfare) \(thoroughfare) \(p.locality!)"
                print(p)
            }
        }
        map.addAnnotation(annotation)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

