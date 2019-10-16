//
//  ViewController.swift
//  d04
//
//  Created by Kai LIN on 3/25/19.
//  Copyright © 2019 Kai LIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func tweetGet(tweets: [Tweet]) {
        self.allTweets = tweets
        tweetTableView.reloadData()
    }
    
    func tweetError(error: NSError) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var tweetTableView: UITableView!
    var allTweets: [Tweet] = []
    var token : String = ""
    
    @IBOutlet weak var searchField: UITextField!
    
    func textFieldShouldReturn(_ searchText: UITextField) -> Bool {
        let text = searchText.text ?? ""
        let controller = APIController(delegate: self, token: token)
        controller.getTweets(str: "q=" + text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&src=typd&lang=fr&count=100&result_type=recent")
        self.view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        
        let CUSTOMER_KEY = "F2OuE6PdVN0lGUS1xrvLxrNYK"
        let CUSTOMER_SECRET = "RUDxXB5XtziUR5p5vPG5bis0hOYbmuoQspsEgnpAPZfpuEopVs"
        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString()
        
        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;CHARSET=UTF-8", forHTTPHeaderField: "Content-type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        for (key, value) in dic {
                            if key as! String == "access_token" {
                                self.token = value as! String
                            }
                        }
                        let controller = APIController(delegate: self, token: self.token)
                        controller.getTweets(str: "q=" + "ecole 42".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&src=typd&lang=fr&count=100&result_type=recent")
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        cell.nameLabel.text = allTweets[indexPath.row].name
        cell.tweetLabel.text = allTweets[indexPath.row].text
        cell.dataLabel.text = allTweets[indexPath.row].date
        cell.layer.borderWidth = 0.8
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 8.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

