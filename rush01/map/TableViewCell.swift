//
//  TableViewCell.swift
//  map
//
//  Created by jiajun wu on 18/10/2019.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import CoreLocation

class TableViewCell: UITableViewCell {

    @IBOutlet weak var placeName: UILabel!
    var location:CLLocation?
    
    var place:(String,CLLocation,String)?{
        didSet{
            if let p = place {
                placeName.text=p.0
                location=p.1
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
