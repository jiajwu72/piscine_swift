//
//  ViewController.swift
//  J4
//
//  Created by jiajun wu on 17/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import UIKit

/**
 * Variable global
 */

let KEY = "F2OuE6PdVN0lGUS1xrvLxrNYK"
let SECRET = "RUDxXB5XtziUR5p5vPG5bis0hOYbmuoQspsEgnpAPZfpuEopVs"
let BEARER = ((KEY+":"+SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,APITwitterDelegate,UITextFieldDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var token:String=""
    var query:String="&src=typd&lang=fr&count=100&result_type=recent"
    var tweets:[Tweet]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.layer.backgroundColor = UIColor.lightGray.cgColor
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " +  BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        search.delegate=self
        search.text="ecole 42"
        self.tableView.rowHeight = UITableView.automaticDimension
        //self.tableView.estimatedRowHeight = 170
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            //print(response)
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let d = data
            do {
                if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d!) as? NSDictionary {
                    for (key, value) in dic {
                        if key as! String == "access_token" {
                            self.token = value as! String
                        }
                    }
                    
                    self.search(data: "ecole 42")
                    //print(self.tweets)
                }
            } catch (let err){
                print(err)
                return
            }
        }
        task.resume()
        
    }
    
    //methods implement APITwitter
    func displayTweets(tweets: [Tweet]) {
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tweetError(error: NSError) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    //tableView methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.name.text = tweets[indexPath.row].name
        cell.date.text = tweets[indexPath.row].date
        cell.texte.text = tweets[indexPath.row].text
        
        cell.layer.cornerRadius = 14
        cell.layer.borderWidth = 4
        return cell
    }
    
    //serch function
    func search(data:String){
        let controller = APIController(delegate: self, token: self.token)
        controller.getTweets(str: "q=" + data.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + self.query)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.text
        self.search(data: searchBar.text!)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

