//
//  ViewController.swift
//  JO3
//
//  Created by jiajun wu on 15/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import UIKit

class ViewController:UIViewController,
        UICollectionViewDelegate,
        UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let list : [String] = [
            "Error_img",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22182.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22594.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22585.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22512.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22182.jpg",
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        //cell.imageView.contentModlet url : String =
        cell.imageLink = list[indexPath.row]
        //cell.imageView.contentMode = UIView.ContentMode.scaleAspectFit
        //cell.imageView.image = img
        return cell
         
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let from = sender! as! CollectionViewCell
        let to = segue.destination as! ImageScrollController
        
        if (from.imageView.image != nil)
        {
            to.image = from.imageView.image
        }else{
            
            let alertController = UIAlertController(title: "Error", message: "Cannot acces to this image", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
             
        }
    }
    
    // Design
    
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let availableHeight = view.frame.height - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let heightPerItem = availableHeight / 5
        return CGSize(width: widthPerItem, height: heightPerItem)
         
        //print("resize")
        //return CGSize(width: 200, height: 200)
    }
    
    // Return inset for section
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // Return spacing for section
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
 }

