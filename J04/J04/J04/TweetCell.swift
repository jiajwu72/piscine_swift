//
//  TweetCell.swift
//  J04
//
//  Created by jiajun wu on 16/10/2019.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    

    var tweet:Tweet? {
        didSet {
            if let t = tweet {
                name.text = t.name
                date.text = t.date
                comment.text = t.text
                //tweetContent.sizeToFit()
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
