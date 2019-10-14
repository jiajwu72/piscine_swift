//
//  ViewController.swift
//  ex01
//
//  Created by jiajun wu on 11/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func click(_ sender: Any) {
        label.text="Hello World !"
    }
}

