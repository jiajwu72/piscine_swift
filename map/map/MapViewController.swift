//
//  MapViewController.swift
//  map
//
//  Created by Jiajun WU on 10/18/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var place:(String,CLLocation,String)?{
        didSet{
            if let p = place {
                
                let region = MKCoordinateRegion(center: p.1.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                print("setRegion")
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        Data.place.forEach{ place in
            let pin:MKPointAnnotation = MKPointAnnotation()
            pin.coordinate=place.1.coordinate
            pin.title=place.0
            pin.subtitle=place.2
            mapView.addAnnotation(pin)
            
        }
        //locationManager.requestWhenInUseAuthorization()
        print("viewDidLoad!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        self.setUpLocationManager()
        let region=MKCoordinateRegion(center: Data.place[0].1.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        
        print("viewDidLoad!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        
    }
    
    func setUpLocationManager(){
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter=10
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("update location:")
        //print(manager.location?.coordinate)
        /*
        if let location=locations.first{
            let region=MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
            
        }
        */
    }
    
    
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        //print("segmented")
        
        print("segmented")
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType=MKMapType.standard
        case 1:
            mapView.mapType=MKMapType.satellite
        case 2:
            mapView.mapType=MKMapType.hybrid
        
        default:
            break
        }
    }
    
    func chooseColor(title:String) -> UIColor {
        switch title {
        case "42":
            return UIColor.blue
        case "Tour eiffel":
            return UIColor.yellow
        case "Notre-Dame":
            return UIColor.magenta
        default:
            return UIColor.green
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let pinView=MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        let color:UIColor=chooseColor(title: (annotation.title as! String))
        pinView.canShowCallout = true
        pinView.pinTintColor=color
        return pinView
        
    }
    
    @IBAction func locateMe(_ sender: Any) {
        print("locate me")
        //print(locationManager)
        //print(CLLocationManager.authorizationStatus())
        //locationManager.requestWhenInUseAuthorization()
        
        
        if let location = locationManager.location?.coordinate{
            //print(location)
            let region=MKCoordinateRegion(center: location, latitudinalMeters: 500,longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    

}
