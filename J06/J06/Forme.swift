//
//  Forme.swift
//  J06
//
//  Created by jiajun wu on 20/10/2019.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import Foundation

class Forme: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var isRec : Bool = true
    
    init(p: CGPoint, maxW:CGFloat,maxH:CGFloat) {
        
        let rand=round(CGFloat(Float(arc4random())/Float(UINT32_MAX)))
        let x=p.x-50
        let y=p.y-50
        //print(rand)
        switch rand {
        case 0.0:
            super.init(frame:CGRect(x: x, y: y, width: 100, height: 100))
        default:
            super.init(frame:CGRect(x: x, y: y, width: 100, height: 100))
            self.isRec=false
            self.layer.cornerRadius=50
        }
        self.backgroundColor=UIColor.random
        self.layer.borderColor=UIColor.black.cgColor
        self.layer.borderWidth=1
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }
    
    override var collisionBoundingPath: UIBezierPath {
        print("collision")
        if self.isRec {
            var rect = bounds
            rect.origin.x -= rect.size.width / 2
            rect.origin.y -= rect.size.height / 2
            print("rec")
            return UIBezierPath(rect: rect)
        }
        else {
            print("cercle")
            let radius = min(bounds.size.width, bounds.size.height) / 2.0
            return UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        }
    }
    
    //override var collisionBoundingPath: UIBezierPath
    
    
}

extension UIColor{
    static var random:UIColor{
        return UIColor(red: CGFloat(Float(arc4random())/Float(UINT32_MAX)),
                       green: CGFloat(Float(arc4random())/Float(UINT32_MAX)),
                       blue: CGFloat(Float(arc4random())/Float(UINT32_MAX)),
                       alpha: 1)
    }
}
