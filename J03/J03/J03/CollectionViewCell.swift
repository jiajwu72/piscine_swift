//
//  CollectionViewCell.swift
//  J03
//
//  Created by Jiajun WU on 10/16/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var alreadyDo:Bool = false
    let queue = DispatchQueue.global(qos : DispatchQoS.background.qosClass)
    static var netWorkCount = 0
    
    func strToImg(path : String) -> UIImage? {
        guard let imgUrl = URL(string: path) else {
            return nil
        }
        if let imgData : NSData = NSData(contentsOf: imgUrl)
        {
            return UIImage(data: imgData as Data)
        }
        return nil
    }
    
    func doAlert(str:String){
        let alert = UIAlertController(title: "An error has detected", message: str , preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    var imgLink : String? {
        didSet {
            self.imageView.contentMode = UIView.ContentMode.scaleAspectFit
            
            //pas encore fetch image
            //UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if (alreadyDo == false)
            {
                self.spinner.hidesWhenStopped = true
                self.spinner.startAnimating()
                //UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                queue.async {
                    let image = self.strToImg(path : self.imgLink!)
                    CollectionViewCell.netWorkCount += 1
                    //print(CollectionViewCell.netWorkCount)
                    DispatchQueue.main.async {
                        
                        
                        if image != nil{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = true
                            self.imageView.image = image
                            self.imageView.contentMode = UIView.ContentMode.scaleAspectFit
                            //self.spinner.stopAnimating()
                            //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }else{
                            self.doAlert(str: "The image is not to be found")
                            //print(CollectionViewCell.netWorkCount)
                        }
                        //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        if CollectionViewCell.netWorkCount == ViewController.nbNetwork {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                        
                        self.spinner.stopAnimating()
                        
                    }
                }
                
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            //UIApplication.shared.isNetworkActivityIndicatorVisible = false
            alreadyDo = true
            
        }
    }
    
    
    
    
}
