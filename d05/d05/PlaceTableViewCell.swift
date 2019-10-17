//
//  PlaceTableViewCell.swift
//  d05
//
//  Created by Kai LIN on 3/26/19.
//  Copyright © 2019 Kai LIN. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    var location : CLLocation?
    
    var place : (String, CLLocation, String)? {
        didSet {
            if let p = place {
                nameLabel?.text = p.0
                name = p.0
                location = p.1
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
