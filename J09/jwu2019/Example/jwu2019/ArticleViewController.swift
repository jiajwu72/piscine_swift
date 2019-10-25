//
//  ViewController.swift
//  jwu2019
//
//  Created by jiajwu72 on 10/22/2019.
//  Copyright (c) 2019 jiajwu72. All rights reserved.
//

import UIKit
import CoreData
import jwu2019

class ArticleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate {
    

    //var manager:ArticleManager!
    @IBOutlet weak var tableView: UITableView!
    var allArticles:[Article]=[]
    var articleManager:ArticleManager!
    var lang:String="en"
    let dateFormatterEn = DateFormatter()
    let dateFormatterFr = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let langue=Locale.current.languageCode
        
        let state = UIApplication.shared.applicationState
        print(state)
        if langue=="fr"{
            self.lang="fr"
        }
        dateFormatterEn.dateFormat="yyyy-MM-dd HH:mm:ss"
        dateFormatterFr.dateFormat="dd-MM-yyyy HH:mm:ss"
        //var me=self
        self.articleManager=ArticleManager(completion: {
            self.reloadArticles(lang: self.lang)
            
        })
        
    }


    func reloadArticles(lang:String){
        
        self.allArticles=articleManager.getAllArticles()
        self.allArticles=self.allArticles.filter{
            //print(String($0.langue!))
            //print(self.lang)
            //print(String($0.langue!)==self.lang)
            return String($0.langue!)==self.lang
        }
        tableView.reloadData()
        //print(allArticles)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell=tableView.dequeueReusableCell(withIdentifier: "ArticleViewCell",for:indexPath) as! ArticleViewCell
        cell.title.text=allArticles[indexPath.row].title
        cell.content.text=allArticles[indexPath.row].content
        
        if let data=allArticles[indexPath.row].image{
            cell.img.image=UIImage(data: data as Data)
        }else{
            cell.img.image=nil
        }
        
        if var dateCreate=allArticles[indexPath.row].dateCreation?.description{
            dateCreate = String(dateCreate.dropLast(6))
            cell.dateCreate.text=dateCreate
            if var dateModif=allArticles[indexPath.row].dateModification?.description{
                dateModif = String(dateModif.dropLast(6))
                if (dateModif != dateCreate){
                    cell.dateModif.text=dateModif
                }
            }
        }
        cell.layer.borderWidth=2
        cell.layer.borderColor=UIColor.magenta.cgColor
        //cell.layer.backgroundColor=UIColor.systemGray.cgColor
        cell.layer.cornerRadius=9
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteTitle=NSLocalizedString("Delete", comment: "Supprimer")
        let deleteAction=UITableViewRowAction(style: .destructive, title: deleteTitle, handler: {
            (action,indexPath) in
            self.articleManager.removeArticle(article: self.allArticles[indexPath.row])
            self.articleManager.save()
            self.allArticles.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
        })
        print("delete")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("modif")
        let cell=tableView.dequeueReusableCell(withIdentifier: "ArticleViewCell",for:indexPath) as! ArticleViewCell
        //cell.
        GestionViewController.oldArticle=self.allArticles[indexPath.row]
        performSegue(withIdentifier: "modifSegue", sender: self.allArticles[indexPath.row])
        //print("enf modif")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("prepare to modif")
        if segue.identifier=="addSegue"{
            GestionViewController.oldArticle=nil
            //print("addSegue")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        if segue.identifier == "logSegue"{
            print("logSegue")
        }
        if segue.identifier == "addSegue"{
            print("addSegue")
        }
        print("uwindSegue")
        self.reloadArticles(lang: lang)
        //self.tableView.reloadData()
    }
   
}

