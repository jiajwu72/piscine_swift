//
//  FirstViewController.swift
//  d05
//
//  Created by Kai LIN on 3/26/19.
//  Copyright © 2019 Kai LIN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.satellite
        case 2:
            mapView.mapType = MKMapType.hybrid
        default:
            break
        }
    }
    
    @IBAction func myLocationButton(_ sender: UIButton) {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(location, 500, 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    var locationManager = CLLocationManager()
    var place : (String, CLLocation, String)? {
        didSet {
            if let p = place {
                let region = MKCoordinateRegionMakeWithDistance(p.1.coordinate, 500, 500)
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Data.place.forEach{ place in
            let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = place.1.coordinate
            pin.title = place.0
            pin.subtitle = place.2
            mapView.addAnnotation(pin)
        }
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(Data.place[0].1.coordinate, 500, 500)
        mapView.setRegion(viewRegion, animated: false)
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "annontation"
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        let color: UIColor = choseColor(title: (annotation.title ?? "")!)
        pinView.pinTintColor = color
        pinView.canShowCallout = true
        return pinView
    }
    
    func choseColor(title: String) -> UIColor{
        switch title {
        case "42":
            return UIColor.magenta
        case "Piscine":
            return UIColor.blue
        case "Tour eiffel":
            return UIColor.gray
        case "Colisée":
            return UIColor.yellow
        case "Statue de la Liberté":
            return UIColor.green
        default:
            return UIColor.red
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

