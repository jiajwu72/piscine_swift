//
//  Tweet.swift
//  J4
//
//  Created by jiajun wu on 17/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import Foundation

struct Tweet:CustomStringConvertible {
    
    let name:String
    let text:String
    let date:String
    
    var description: String {
        return "Name : \(name)\nDate: \(date)\nTweet : \(text)"
    }
}
