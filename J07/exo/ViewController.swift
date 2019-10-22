//
//  ViewController.swift
//  exo
//
//  Created by Jiajun WU on 10/18/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import ForecastIO
import  RecastAI
import MapKit


class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var text: UITextField!
    
    let bot = RecastAIClient(token : "4c2c4e6447ecbdc03e06ca74e8497155", language: "fr")
    let darkSkyClient = DarkSkyClient(apiKey: "a265eff50f4af5817a0cac58a3afa3a7")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func make(_ sender: UIButton) {
        makeRecastRequest(request: text.text!)
    }
    
    func makeRecastRequest(request: String) {
        if request != ""{
            self.bot.textConverse(request, successHandler: recastResponse, failureHandle: recastError)
        } else {
            self.result.text = "Request can't be empty"
        }
    }
    
    func recastResponse(response: ConverseResponse){
        print("REPONSE = \(response)")
        if let myRes = response.entities?["location"] as? [[String : Any]]{
            let lat = myRes[0]["lat"] as! Double?
            let lng = myRes[0]["lng"] as! Double?
            
            let myLoc = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
            self.darkSkyClient.getForecast(location: myLoc, completion: { result in
                switch result {
                case .success(let value, _):
                    let formatted = myRes[0]["formatted"] as! String?
                    DispatchQueue.main.async {
                        self.result.text = "\(formatted!) is \((value.hourly!.summary)!)"
                    }
                case .failure(let error):
                    print(error)
                }
            })
        } else {
            if (response.intents?.count != 0) {
                if let myRes = response.intents as? [[String : Any]] {
                    if let mySlug = myRes[0]["slug"] as? String{
                        print(mySlug)
                        DispatchQueue.main.async {
                            self.result.text = "Error"
                        }
                    }

                }
            } else {
                self.result.text = "Error"
                print("Error")
            }
        }
    }
    
    func recastError(error: Error) {
        self.result.text = "Error"
        print(error)
    }
    
}

