//
//  ViewController.swift
//  J04
//
//  Created by Jiajun WU on 10/16/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit

let KEY = "F2OuE6PdVN0lGUS1xrvLxrNYK"
let SECRET = "RUDxXB5XtziUR5p5vPG5bis0hOYbmuoQspsEgnpAPZfpuEopVs"
let BEARER = ((KEY+":"+SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))

class ViewController: UITableViewController,APITwitterDelegate,UISearchBarDelegate,UISearchDisplayDelegate {
    
    
    var token = ""
    var tweets:[Tweet] = []
    var keyword = "ecole 42"
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tableV: UITableView!
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        /*
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " +  BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
         */
    }

    //TweeterDelegate implement methods
    
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

    
    //SearchBar methods
    /*
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        keyword = text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
     x*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return nil! as UITableViewCell
    }
}

