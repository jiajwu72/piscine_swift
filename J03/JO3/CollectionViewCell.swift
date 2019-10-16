//
//  CollectionViewCell.swift
//  JO3
//
//  Created by jiajun wu on 15/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var alreadyTryedToFetchImage:Bool = false
    
    let queue = DispatchQueue.global(qos: DispatchQoS.background.qosClass)
    
    func urlToUIImage(stringURL: String) -> UIImage? {
        guard let imageURL = URL(string: stringURL) else {return nil}
        if let imageData: NSData = NSData(contentsOf: imageURL) {
            return UIImage(data: imageData as Data)
        }
        return nil
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    var imageLink: String?  {
        didSet {
            self.imageView.contentMode = UIView.ContentMode.scaleAspectFit
            if (alreadyTryedToFetchImage == false) {
                self.spinner.hidesWhenStopped = true
                self.spinner.startAnimating()
                
                queue.async {
                    let image = self.urlToUIImage(stringURL: self.imageLink!)
                    DispatchQueue.main.async {
                        if (image != nil) {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = true
                            self.imageView.image = image
                            //self.imageView.contentMode = UIView.ContentMode.scaleAspectFit
                        } else {
                            //self.imageView.image = UIImage(named:"error-image")!
                            //self.imageView.contentMode = UIView.ContentMode.scaleAspectFit
                            self.launchAlert(str: "Unable to load image : "+self.imageLink!)
                        }
                        self.spinner.stopAnimating()
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
            alreadyTryedToFetchImage = true
        }
    }
     
}
