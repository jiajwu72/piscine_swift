//
//  GestionViewController.swift
//  jwu2019_Example
//
//  Created by jiajun wu on 24/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import jwu2019

class GestionViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var lang:String="en"
    var articleManager:ArticleManager!
    var isAdd:Bool=true
    static var oldArticle:Article!
    let imagePicker=UIImagePickerController()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let langue=Locale.current.languageCode
        imagePicker.delegate=self
        imageView.contentMode=UIViewContentMode.scaleAspectFit
        articleManager=ArticleManager(completion: {})
        if langue=="fr"{
            self.lang=langue!
        }
        if GestionViewController.oldArticle != nil {
            self.isAdd=false
        }
        if !isAdd{
            print("!isAdd")
            titleField.text=GestionViewController.oldArticle.title
            contentField.text=GestionViewController.oldArticle.content
            if GestionViewController.oldArticle.image != nil{
                imageView.image=UIImage(data: GestionViewController.oldArticle!.image! as Data)
            }
        }else{
            //print("Add!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare save")
        if titleField.text != nil && titleField.text != "" && contentField.text != nil && contentField.text != ""{
            print("correct")
            if isAdd{
                print("isAdd")
                let newArticle=articleManager.newArticle()
                newArticle.title=titleField.text
                newArticle.content=contentField.text
                newArticle.dateCreation=NSDate()
                newArticle.dateModification=NSDate()
                if imageView.image != nil {
                    newArticle.image=UIImagePNGRepresentation(imageView.image!) as NSData?
                }
                newArticle.langue=lang
                //print(articleManager.getAllArticles())
                articleManager.save()
            }else{
                GestionViewController.oldArticle.title=titleField.text
                GestionViewController.oldArticle.content=contentField.text
                GestionViewController.oldArticle.dateModification=NSDate()
                if imageView.image != nil {
                    GestionViewController.oldArticle.image=UIImagePNGRepresentation(imageView.image!) as NSData?
                }
                //oldArticle.langue=lang
                articleManager.save()
            }
        }
    }
    
    
    @IBAction func library(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("library")
            imagePicker.sourceType = .photoLibrary
            present(imagePicker,animated: true,completion: nil)
        }
    }
    
    @IBAction func camera(_ sender: UIButton) {
        print("begin camera")
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("camera")
            imagePicker.sourceType = .camera
            present(imagePicker,animated: true,completion: nil)
        }else{
            print("camera not avaible")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("imagePickerController")
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
            let size=min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
            //imageView.image=image.resized(size: size)
            
            imageView.image=image
            print("pick something")
        }else{
            print("picker error")
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindModif(_ segue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        
        print("modifSegue")
        
    }
    
    
}

extension UIImage{
    func resized(size:CGFloat)->UIImage?{
        let size=CGSize(width: size, height: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndPDFContext()
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

