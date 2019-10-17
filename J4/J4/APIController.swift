//
//  APIController.swift
//  J4
//
//  Created by jiajun wu on 17/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import Foundation

protocol APITwitterDelegate:class {
    func displayTweets(tweets:[Tweet])
    func tweetError(error:NSError)
}

class APIController {
    weak var delegate:APITwitterDelegate?
    let token:String
    
    init(delegate:APITwitterDelegate, token:String) {
        self.delegate=delegate
        self.token=token
    }
    
    func getTweets(str:String){
        let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?" + str)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                DispatchQueue.main.async(execute: {
                    self.delegate?.tweetError(error: error! as NSError)
                })
                return
            }
            
            let d = data
            do {
                var tweets: [Tweet] = []
                if let resp: NSDictionary = try JSONSerialization.jsonObject(with: d!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let statuses: [NSDictionary] = resp["statuses"] as? [NSDictionary] {
                        for status in statuses {
                            let name = (status["user"] as? NSDictionary)?["name"] as? String
                            let text = status["text"] as? String
                            let date = status["created_at"] as? String
                            if (name != nil) && (text != nil) && (date != nil) {
                                let dateFormatter = DateFormatter()
                                //initial dateFormat of tweeter
                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                if let date = dateFormatter.date(from: date!) {
                                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                    let newDate = dateFormatter.string(from: date)
                                    tweets.append(Tweet(name: name!, text: text!, date: newDate))
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            //print(tweets)
                            self.delegate?.displayTweets(tweets: tweets)
                            print(tweets)
                        }
                    }
                }
            } catch (let err){
                DispatchQueue.main.async(execute: {
                    self.delegate?.tweetError(error: err as NSError)
                })
                return
            }
            
        }
        task.resume()
    }
}

