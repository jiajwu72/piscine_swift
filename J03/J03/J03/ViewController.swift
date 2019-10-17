//
//  ViewController.swift
//  J03
//
//  Created by Jiajun WU on 10/16/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                        UICollectionViewDataSource,
UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let list : [String] = [
        "Error path",
        "https://wallpapersite.com/images/wallpapers/moon-4096x2304-planets-clouds-4k-9215.jpg",
        "https://apod.nasa.gov/apod/image/1903/HoughtonAurora_03_2019.jpg",
        "https://initiate.alphacoders.com/download/wallpaper/386747/images8/jpg/608164594712202/54803",
        "https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Moon_nearside_LRO.jpg/240px-Moon_nearside_LRO.jpg"
    ]
    static var nbNetwork = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.nbNetwork = list.count
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imgLink = list[indexPath.row]
        print(CollectionViewCell.netWorkCount)
        
        if CollectionViewCell.netWorkCount == list.count{
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        return cell
    }
    /*
    func doAlert(str:String){
        let alert = UIAlertController(title: "An error has detected", message: str , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let from = sender as! CollectionViewCell
        let to = segue.destination as! ImageScrollController
        
        if from.imageView.image != nil {
            to.image = from.imageView.image
        }else{
            let alertController = UIAlertController(title: "Error", message: "Cannot acces to this image", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    


}


