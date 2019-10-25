//
//  LoginViewController.swift
//  jwu2019_Example
//
//  Created by jiajun wu on 24/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    
    let txt=LAContext()
    var strLocal=NSLocalizedString("You need to be authenticate", comment: "Vous devrez être authentifier")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        print("login")
        if txt.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
            txt.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: strLocal, reply: {
                (success, error) in
                if success{
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "logSegue", sender: nil)
                        //print("login")
                    }
                }else{
                    print("authentificate echoue")
                }
            })
        }
    }
    
    

}
