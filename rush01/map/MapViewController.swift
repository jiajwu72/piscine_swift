//
//  MapViewController.swift
//  map
//
//  Created by Jiajun WU on 10/18/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
//import SwiftyJSON

class MapViewController: UIViewController,UITextFieldDelegate,UISearchBarDelegate,LocateOnTheMap,CLLocationManagerDelegate,GMSMapViewDelegate{
    
    
    //var currentPosition: CLLocationCoordinate2D
    
    
    @IBOutlet weak var mapContainer: UIView!
    
    
    var mapView:GMSMapView!
    var searchController:SearchTableController!
    var resArray=[String]()
    var locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    var currentPosition:CLLocationCoordinate2D!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set searchController
        print("vieDidLoad")
        searchController=SearchTableController()
        searchController.delegate=self
        
        //set map
        mapView=GMSMapView(frame: mapContainer.frame)
        //mapView.delegate=self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //set locationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        getCurrentPosition()
        


        
        view.addSubview(mapView)
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        let searchController=UISearchController(searchResultsController: self.searchController)
        searchController.searchBar.delegate=self
        self.present(searchController,animated: true,completion: nil)
    }
    
    /*
    ** Locate map with longitud anf lagitude
     */
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        let placeClient=GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil){ res,error in
            self.resArray.removeAll()
            if res==nil{
                return
            }
            for item in res!{
                /*
                if let st=item as? GMSAutocompletePrediction{
                    self.resArray.append(st.attributedFullText.string)
                }
                */
                self.resArray.append(item.attributedFullText.string)
            }
        }
        //print(self.resArray)
        self.searchController.reloadSearchData(array: resArray)
    }
    
    func locateWithCoord(long: Double, lat: Double, text: String) {
        DispatchQueue.main.async {
            let pos=CLLocationCoordinate2D(latitude: lat, longitude: long)
            let marker=GMSMarker(position: pos)
            
            let camera=GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 11)
            self.mapView.camera=camera
            marker.title="\(text)"
            marker.map = self.mapView
        }
    }
    
    func launchAlert(str: String) {
        
        DispatchQueue.main.async {
            print("l0")
            let alertController = UIAlertController(title: "Error", message: str, preferredStyle: UIAlertController.Style.alert)
            print("l1")
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            print("l2")
            self.present(alertController, animated: true)
            print("l3")
        }
        
        
        //print("end launchAlert")
    }
    
    func resetMap() {
        print("reset map")
        mapView.clear()
    }
    
    
    public func drawItineraryFrom2(origin:CLLocationCoordinate2D,dest:CLLocationCoordinate2D){
        //print("draw itinerary")
        
        DispatchQueue.main.async {
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            print("draw itinerary")
            
            let key="AIzaSyBk6MEYcqHK1wxkabul8zeTb8ykuPq_1nE"
            
            let urlPath="https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(dest.latitude),\(dest.longitude)&sensor=false&mode=drive&key=\(key)"
            //print(urlPath)
            
            let url = URL(string:urlPath )!
            //print(url)
            
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if error != nil {
                    //print(error!.localizedDescription)
                } else {
                    do {
                        if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                            //print(json["routes"])
                            print("in draw")
                            let preRoutes:NSArray = (json["routes"] as? NSArray)!
                            
                            if (preRoutes != nil && preRoutes.count != 0) {
                                print(0)
                                if let routes:NSDictionary = preRoutes[0] as? NSDictionary{
                                    print(1)
                                    if let routeOverviewPolyline:NSDictionary=routes.value(forKey: "overview_polyline") as? NSDictionary{
                                        print(2)
                                        if let polyString:String = routeOverviewPolyline.object(forKey: "points") as? String{
                                            print("dispatch draw")
                                            DispatchQueue.main.async(execute: {
                                                let path = GMSPath(fromEncodedPath: polyString)
                                                let polyline = GMSPolyline(path: path)
                                                polyline.strokeWidth = 5.0
                                                polyline.strokeColor = UIColor.green
                                                polyline.map = self.mapView
                                            })
                                        }
                                    }
                                }
                            }else{
                                print("-3")
                                self.launchAlert(str: "itinerary can't be drawed")
                                print("-3.5")
                            }
                            
                        }
                    } catch {
                        print("parsing error")
                    }
                }
            })
            
            task.resume()
            print("finish in function draw2")
            
        }
        
    }
    
    func drawItinerary(dest:CLLocationCoordinate2D){
        //print("draw itinerary")
        
        DispatchQueue.main.async {
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            print("draw itinerary")
            
            let key="AIzaSyBk6MEYcqHK1wxkabul8zeTb8ykuPq_1nE"
            
            let urlPath="https://maps.googleapis.com/maps/api/directions/json?origin=\(self.currentPosition.latitude),\(self.currentPosition.longitude)&destination=\(dest.latitude),\(dest.longitude)&sensor=false&mode=drive&key=\(key)"
            //print(urlPath)
            
            let url = URL(string:urlPath )!
            //print(url)
            
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if error != nil {
                    //print(error!.localizedDescription)
                } else {
                    do {
                        if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                            //print(json["routes"])
                            print("in draw")
                            let preRoutes:NSArray = (json["routes"] as? NSArray)!
                            
                            if (preRoutes != nil && preRoutes.count != 0) {
                                print(0)
                                if let routes:NSDictionary = preRoutes[0] as? NSDictionary{
                                    print(1)
                                    if let routeOverviewPolyline:NSDictionary=routes.value(forKey: "overview_polyline") as? NSDictionary{
                                        print(2)
                                        if let polyString:String = routeOverviewPolyline.object(forKey: "points") as? String{
                                            print("dispatch draw")
                                            DispatchQueue.main.async(execute: {
                                                let path = GMSPath(fromEncodedPath: polyString)
                                                let polyline = GMSPolyline(path: path)
                                                polyline.strokeWidth = 5.0
                                                polyline.strokeColor = UIColor.green
                                                polyline.map = self.mapView
                                            })
                                        }
                                    }
                                }
                            }else{
                                print("-3")
                                self.launchAlert(str: "itinerary can't be drawed")
                                print("-3.5")
                            }
                            
                        }
                    } catch {
                        print("parsing error")
                    }
                }
            })
            
            task.resume()
            print("finish in function draw")
            
        }
        
    }
    
    func getCurrentPosition(){
        var pos:CLLocationCoordinate2D!
        if let location = locationManager.location?.coordinate{
            self.currentPosition=location
        }
        if (self.currentPosition != nil)
        {
            let camera=GMSCameraPosition.camera(withLatitude: self.currentPosition.latitude, longitude: self.currentPosition.longitude, zoom: 11)
            mapView.camera=camera
        }
        
        //return pos
    }
    
    @IBAction func locateMe(_ sender: Any) {
        print("locate me")
        
        if let location = locationManager.location?.coordinate{
            let camera=GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 11)
            mapView.camera=camera
            
            let pos=CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let marker=GMSMarker(position: pos)
            marker.title="My current address"
            marker.icon = GMSMarker.markerImage(with: UIColor.green)
            marker.map = self.mapView
        }
    }
    
    @IBAction func drawWind(_ sender: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        print("unwind")
        if let searchView = sender.source as? SearchViewController{
            if ((searchView.firstMarker != nil) && (searchView.secondMarker != nil))
            {
                mapView.clear()
                searchView.firstMarker.map=self.mapView
                searchView.secondMarker.map=self.mapView
                self.drawItineraryFrom2(origin: searchView.firstMarker.position, dest: searchView.secondMarker.position)
                let camera=GMSCameraPosition.camera(withLatitude: searchView.secondMarker.position.latitude, longitude: searchView.secondMarker.position.longitude, zoom: 8)
                mapView.camera=camera
            }
            
        }
        
        //print(unwindSegue.source a)
    }
    
}
