//
//  APITwitterDelegate.swift
//  d04
//
//  Created by Kai LIN on 3/25/19.
//  Copyright © 2019 Kai LIN. All rights reserved.
//

import Foundation

protocol APITwitterDelegate : class {
    func tweetGet(tweets : [Tweet])
    func tweetError(error : NSError)
}
