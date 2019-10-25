//
//  ArticleViewCell.swift
//  jwu2019_Example
//
//  Created by jiajun wu on 24/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ArticleViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var dateCreate: UILabel!
    @IBOutlet weak var dateModif: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func DeleteArticle(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
