//
//  ViewController.swift
//  J02
//
//  Created by Jiajun WU on 10/14/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//


import UIKit

class Datas{
    //static var deaths:[Death]
 
    static var deaths:[Death] = [Death(name: "aa", desc: "in toilet", date: "01 mars 2019 07:07:07"),
    Death(name: "bb", desc: "in toilet", date: "01 mars 2019 07:07:07"),
    Death(name: "dd", desc: "in toilet", date: "01 mars 2019 07:07:07")]
    init() {
        /*
        Datas.deaths = [Death(name: "aa", desc: "in toilet", date: "01 mars 2019 07:07:07"),
                       Death(name: "bb", desc: "in toilet", date: "01 mars 2019 07:07:07"),
                       Death(name: "dd", desc: "in toilet", date: "01 mars 2019 07:07:07")]
        */
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
 
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToFirstVC(segue:UIStoryboardSegue) {
        
        
        self.tableView.reloadData()
    }

 
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //print(Datas.deaths.count)
        return Datas.deaths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableViewCell", for : indexPath) as? CellTableViewCell
        cell?.name.text = Datas.deaths[indexPath.row].name
        cell?.desc.text = Datas.deaths[indexPath.row].desc
        cell?.date.text = Datas.deaths[indexPath.row].date
        
        /*
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.reloadData()
        */
        return cell!
        
    }
    
    
    
}
