//
//  SearchViewController.swift
//  map
//
//  Created by jiajun wu on 26/10/2019.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchViewController: UIViewController ,UITextFieldDelegate,UISearchBarDelegate,CLLocationManagerDelegate,GMSMapViewDelegate,SetMarker{
    
    static var mapVieww:MapViewController!

    @IBOutlet weak var departField: UITextField!
    @IBOutlet weak var arriveField: UITextField!
    
    var resArray=[String]()
    var searchController:SecondSearchTableController!
    var firstMarker:GMSMarker!
    var secondMarker:GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchController=SecondSearchTableController()
        self.searchController.delegate=self
        departField.delegate=self
        arriveField.delegate=self
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //print(textField.text)
        //print(textField==departField)
        if textField==departField
        {
            SecondSearchTableController.isFirst=true
        }else{
            SecondSearchTableController.isFirst=false
        }
        let searchController=UISearchController(searchResultsController: self.searchController)
        searchController.searchBar.delegate=self
        self.present(searchController,animated: true,completion: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        //print("edit")
        //departField.text=searchText
        let placeClient=GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil){ res,error in
            self.resArray.removeAll()
            if res==nil{
                return
            }
            for item in res!{
                self.resArray.append(item.attributedFullText.string)
            }
        }
        //print(self.resArray)
        self.searchController.reloadSearchData(array: resArray)
    }
    
    
    func setFirstMarker(lat: Double, long: Double, desc:String) {
        DispatchQueue.main.async {
            print("set First Marker")
            let pos=CLLocationCoordinate2D(latitude: lat, longitude: long)
            self.firstMarker=GMSMarker(position: pos)
            self.firstMarker.title=desc
            self.firstMarker.icon = GMSMarker.markerImage(with: UIColor.yellow)
            self.departField.text=desc
        }
    }
    
    func setSecondMarker(lat: Double, long: Double, desc:String) {
        DispatchQueue.main.async {
            print("set Seconds Marker")
            let pos=CLLocationCoordinate2D(latitude: lat, longitude: long)
            self.secondMarker=GMSMarker(position: pos)
            self.secondMarker.title=desc
            self.arriveField.text=desc
        }
    }
    
    @IBAction func search(_ sender: Any) {
        //print("seach itinary")
        //performSegue(withIdentifier: "drawRouteSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MapViewController.drawItineraryFrom2(origin: firstMarker.position, dest: secondMarker.position)
        //self.delega
    }
    
}
