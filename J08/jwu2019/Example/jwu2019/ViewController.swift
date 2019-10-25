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

class ViewController: UIViewController {

    var manager:ArticleManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.manager=ArticleManager(completion: {
            DispatchQueue.main.async {
                //return
                self.show()
            }
        })
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func show(){
        //print("show")
        //return
        guard let article1 = manager?.newArticle() else { print("ERROR : COULD NOT CREATE ARTICLE\n"); return }
        //return
        article1.title = "Bonjour 1"
        article1.content = "1ère article en français"
        article1.langue = "fr"
        article1.image = nil
        article1.dateCreation = NSDate()
        article1.dateModification = NSDate()
        
        //return 
        guard let article2 = manager?.newArticle() else { print("ERROR : COULD NOT CREATE ARTICLE\n"); return }
        article2.title = "Bonjour 2"
        article2.content = "2ème article en français"
        article2.langue = "fr"
        article2.image = nil
        article2.dateCreation = NSDate()
        article2.dateModification = NSDate()
        
        
        guard let article3 = manager?.newArticle() else { print("ERROR : COULD NOT CREATE ARTICLE\n"); return }
        article3.title = "Bonjour 3"
        article3.content = "3ème article en français"
        article3.langue = "fr"
        article3.image = nil
        article3.dateCreation = NSDate()
        article3.dateModification = NSDate()
        
        guard let article4 = manager?.newArticle() else { print("ERROR : COULD NOT CREATE ARTICLE\n"); return }
        article4.title = "Hello 4"
        article4.content = "4th article in english"
        article4.langue = "fr"
        article4.image = nil
        article4.dateCreation = NSDate()
        article4.dateModification = NSDate()
        
        print("Created 4 articles :\n\(article1.description)\n\(article2.description)\n\(article3.description)\n\(article4.description)")
        
        self.manager?.save()

        let allArticles = self.manager?.getAllArticles()
        print("All articles in our library : \n\n\(allArticles!)")
    }
    
}

