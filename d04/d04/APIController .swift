//
//  APIController .swift
//  d04
//
//  Created by Kai LIN on 3/25/19.
//  Copyright © 2019 Kai LIN. All rights reserved.
//

import Foundation

class APIController {
    weak var delegate : APITwitterDelegate?
    let token : String
    let CUSTOMER_KEY = "F2OuE6PdVN0lGUS1xrvLxrNYK"
    let CUSTOMER_SECRET = "RUDxXB5XtziUR5p5vPG5bis0hOYbmuoQspsEgnpAPZfpuEopVs"
    
    init(delegate : APITwitterDelegate, token : String) {
        self.delegate = delegate
        self.token = token
    }
    
    func getTweets(str : String){
        var newTweets : [Tweet] = []
        let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?" + str)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                DispatchQueue.main.async(execute: {self.delegate?.tweetError(error: error! as NSError)})
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let statuses : [NSDictionary] = dic["statuses"] as? [NSDictionary] {
                            for status in statuses {
                                let name = (status["user"] as? NSDictionary)?["name"] as? String
                                let text = status["text"] as? String  //"test \n test \n test \n test \n test \n test \n"
                                let created_at = status["created_at"] as? String
                                if name != nil && text != nil && created_at != nil {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                    if let date = dateFormatter.date(from: created_at!) {
                                        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                        let newDate = dateFormatter.string(from: date)
                                        newTweets.append(Tweet(name: name!, text: text!, date: newDate))
                                    }
                                }
                            }
                            DispatchQueue.main.async(execute: {self.delegate?.tweetGet(tweets: newTweets)})
                        }
                    }
                }
                catch (let err) {
                    DispatchQueue.main.async(execute: {self.delegate?.tweetError(error: err as NSError)})
                }
            }
            
        }
        task.resume()
    }
    
}
