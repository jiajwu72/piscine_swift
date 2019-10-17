//
//  ImageScrollController.swift
//  J03
//
//  Created by Jiajun WU on 10/16/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit

class ImageScrollController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView:UIImageView?
    var image:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (image != nil)
        {
            imageView = UIImageView(image: image)
            self.setUp()
            print("loaded")
        }
        // Do any additional setup after loading the view.
    }
    
    func setImgSize(){
        let screenWidth = self.view.bounds.width
        let imgFullSize = imageView?.frame.size
        let rule = imgFullSize!.height / imgFullSize!.width
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth * rule)
    }
    
    func setUp(){
        self.imageView?.contentMode = .scaleAspectFit
        self.scrollView.maximumZoomScale = 100
        self.scrollView.minimumZoomScale = 1
        self.setImgSize()
        scrollView.addSubview(self.imageView!)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

}
