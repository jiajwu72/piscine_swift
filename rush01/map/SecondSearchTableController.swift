//
//  SearchTableController.swift
//  map
//
//  Created by jiajun wu on 25/10/2019.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol SetMarker {
    func setFirstMarker(lat:Double,long:Double,desc:String)
    func setSecondMarker(lat:Double,long:Double,desc:String)
}

class SecondSearchTableController: UITableViewController {

    var delegate:SetMarker!
    var res:[String]!
    static var isFirst:Bool=true
    static var text:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        res=Array()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return res.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text=res[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.dismiss(animated: true, completion: nil)
        //self.delegate.resetMap()
        var key="AIzaSyBk6MEYcqHK1wxkabul8zeTb8ykuPq_1nE"
        let url=URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(res[indexPath.row])&key=\(key)&sensor=false".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        //print(url?.absoluteString)
        
        let urlRequest=URLRequest(url: url!)
        let task=URLSession.shared.dataTask(with: urlRequest){ data,response,error in
            do{
                if data != nil {
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                    print(dic.description)
                    let lat = ((((dic.value(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "geometry") as! NSDictionary).object(forKey: "location") as! NSDictionary).value(forKey: "lat") as! Double
                    let long = ((((dic.value(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "geometry") as! NSDictionary).object(forKey: "location") as! NSDictionary).value(forKey: "lng") as! Double
                    let desc=((dic.value(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "formatted_address") as! String
                    
                    print(desc)
                    
                    if SecondSearchTableController.isFirst{
                        self.delegate.setFirstMarker(lat: lat, long: long, desc:desc)
                    }else{
                        self.delegate.setSecondMarker(lat: lat, long: long, desc:desc)
                    }
                    //SecondSearchTableController.text
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
        self.dismiss(animated: true, completion: nil)
        //print("finish tap")
    }

    func reloadSearchData(array:[String]){
        self.res=array
        tableView.reloadData()
    }
    
}
