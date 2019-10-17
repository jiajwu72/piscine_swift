//
//  APIController.swift
//  J04
//
//  Created by jiajun wu on 16/10/2019.
//  Copyright © 2019 Jiajun WU. All rights reserved.
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
        
    }
}
