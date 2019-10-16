//
//  AddPersonViewController.swift
//  J02
//
//  Created by Jiajun WU on 10/14/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var desc: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //date.datePickerMode = UIDatePicker.Mode.date
        let currenDate = NSDate()
        //let calendar = Calendar.current
        //let minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date()).date
        date.minimumDate = currenDate as Date
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var _ : ViewController = segue.destination as! ViewController
        //Datas.deaths.append(Death(name : "zz",desc: "go die", date : "05 mars 2019 07:07:07"))
        if let a : String = name.text, !name.text!.isEmpty {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier : "FR-fr")
            formatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
            
            let b : String = formatter.string(from: date.date)
            let c : String = desc.text
            Datas.deaths.append(Death(name : a,desc: c, date :b))
        }
        print("add Him")
        
    }
    
    

}
