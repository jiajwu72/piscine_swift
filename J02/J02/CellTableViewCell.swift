//
//  CellTableViewCell.swift
//  J02
//
//  Created by Jiajun WU on 10/14/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit

class Death {
    var name:String
    var desc:String
    var date:String
    
    init(name:String,desc:String,date:String) {
        self.name=name
        self.desc=desc
        self.date=date
    }
    
}

class CellTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}


