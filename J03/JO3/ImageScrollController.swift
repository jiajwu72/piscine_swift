//
//  ImageScrollController.swift
//  JO3
//
//  Created by jiajun wu on 16/10/2019.
//  Copyright © 2019 jiajun wu. All rights reserved.
//

import UIKit

class ImageScrollController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView : UIImageView?
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //guard image != nil else {return }
        
        //guard imageView != nil else {return }
        
        imageView = UIImageView(image: image)
        self.setViews ()
        setImageSize(screenWidth: self.view.bounds.width);
        scrollView.addSubview(self.imageView!)
    }
    
    func setViews() {
        self.imageView!.contentMode = .scaleAspectFill;
        //self.imageView!.clipsToBounds = true;
        //scrollView.isScrollEnabled = true;
        scrollView.maximumZoomScale = 100.0;
        scrollView.minimumZoomScale = 1.0;
        //scrollView.showsHorizontalScrollIndicator = true
        //scrollView.showsVerticalScrollIndicator = true
    }
    func setImageSize(screenWidth: CGFloat) {
        let imageFullSize = imageView!.frame.size
        let imageRatio = imageFullSize.height / imageFullSize.width
        self.imageView!.frame = CGRect(
            x: 0,
            y: 0,
            width: screenWidth,
            height: screenWidth * imageRatio
        );
        scrollView.contentSize = imageView!.frame.size;
    }
    /*
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setImageSize(screenWidth: size.width);
    }
    */
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
 
    /*
    override func viewWillLayoutSubviews() {
        <#code#>
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        <#code#>
    }
     */
}
