//
//  ViewController.swift
//  ex02
//
//  Created by jiajun wu on 11/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var res: UILabel!
    
    /*
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    */
    //var result=""
    var previousNbr=""
    var currentNbr=""
    var currentOperation=""
    //var SecondNbr=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        res.text = "0"
        
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        //print("numbers")
        
        currentNbr = currentNbr + String(sender.tag)
        res.text = currentNbr
        
    }
    
    
    
    
    @IBAction func deleteAll(_ sender: UIButton) {
        print("deleteAll")
        res.text = "0"
        previousNbr = ""
        currentNbr = ""
        currentOperation = ""
    }
    
    
    @IBAction func neg(_ sender: Any) {
        
        if currentNbr != ""{
            currentNbr = "\(-1 * Double(currentNbr)!)"
        }
            
        else if previousNbr != ""{
            currentNbr = "\(-1 * Double(previousNbr)!)"
        }
            
        res.text = currentNbr
    }
    
    @IBAction func divide(_ sender: Any) {
        print("/")
        cal(operation : "/")
    }
    
    @IBAction func multiply(_ sender: Any) {
        print("*")
        cal(operation : "*")
    }
    
    
    @IBAction func add(_ sender: Any) {
        print("+")
        cal(operation : "+")
    }
    
    
    @IBAction func Subtract(_ sender: Any) {
        print("-")
        cal(operation : "-")
    }
    
    
    @IBAction func equal(_ sender: UIButton) {
        print("equal")
        cal(operation : "=")
    }
    
    
    
    func cal(operation:String){
        print(operation)
        if operation != "" {
            if(currentNbr != ""){
                
                if(previousNbr != ""){
                    if(currentOperation == "+"){
                        res.text = "\(Double(previousNbr)! + Double(currentNbr)!)"
                    }
                    else if(currentOperation == "-"){
                        res.text = "\(Double(previousNbr)! - Double(currentNbr)!)"
                    }
                    else if(currentOperation == "*"){
                        res.text = "\(Double(previousNbr)! * Double(currentNbr)!)"
                    }
                    else if(currentOperation == "/"){
                        if Int(currentNbr) == 0{
                            res.text="Error"
                            previousNbr=""
                            currentNbr=""
                            currentOperation=""
                            return
                        }
                        
                        res.text = "\(Double(previousNbr)! / Double(currentNbr)!)"
                        
                    }
                    
                }
                if (Double(res.text!)! > Double(2147483649)){
                    res.text = "2147483649.0"
                }
                else if (Double(res.text!)! < Double(-2147483649)){
                    res.text = "-2147483649.0"
                }
                previousNbr = res.text!
                currentNbr=""
            }
            if operation == "="{
                currentOperation = ""
            }
            else{
                currentOperation=operation
            }
            
        }
        else{
            currentOperation=operation
            previousNbr=currentNbr
            currentNbr=""
        }
        
    }
}

