//
//  Model.swift
//  d04
//
//  Created by Kai LIN on 3/25/19.
//  Copyright © 2019 Kai LIN. All rights reserved.
//

import Foundation

struct Tweet : CustomStringConvertible {
    let name : String
    let text : String
    let date : String
    
    var description: String {
        return "\(name) \(date) \(text)"
    }
    
}
