//
//  infoCell.swift
//  J02
//
//  Created by jiajun wu on 12/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import UIKit

class infoCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var death:(String, String, String)? {
        didSet {
            if let d = death {
                name?.text = d.0
                desc?.text = d.1
                date?.text = d.2
            }
        }
    }
}
