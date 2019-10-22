//
//  ViewController.swift
//  J06
//
//  Created by Jiajun WU on 10/20/19.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var gravity:UIGravityBehavior!
    var animator:UIDynamicAnimator!
    var collision:UICollisionBehavior!
    var elasticity:UIDynamicItemBehavior!
    var motionManager=CMMotionManager()
    var limitSize:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator=UIDynamicAnimator(referenceView: view)
        gravity=UIGravityBehavior(items:[])
        collision=UICollisionBehavior(items: [])
        collision.translatesReferenceBoundsIntoBoundary=true
        
        elasticity=UIDynamicItemBehavior(items: [])
        elasticity.elasticity=0.32
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(elasticity)
        
        limitSize=min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        
        
    }

    

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        let position=sender.location(in: view)
        let form=Forme(p: position, maxW: self.view.bounds.width, maxH: self.view.bounds.height)
        view.addSubview(form)
        gravity.addItem(form)
        collision.addItem(form)
        elasticity.addItem(form)
        
        let pan=UIPanGestureRecognizer(target: self, action: #selector(self.panGest(gesture:)))
        form.addGestureRecognizer(pan)
        //print("tap0")
        let pinch=UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGest(gesture:)))
        form.addGestureRecognizer(pinch)
        //print("tap1")
        
        let rotate=UIRotationGestureRecognizer(target: self, action: #selector(self.rotateGest(gesture:)))
        form.addGestureRecognizer(rotate)
    }
    
    @objc func panGest(gesture:UIPanGestureRecognizer){
        if let _=gesture.view{
            switch gesture.state {
            case .began:
                self.gravity.removeItem(gesture.view!)
            case .changed:
                gesture.view?.center=gesture.location(in: gesture.view?.superview)
                animator.updateItem(usingCurrentState: gesture.view!)
            case .ended:
                self.gravity.addItem(gesture.view!)
            default:
                break
            }
        }
    }
    
    @objc func pinchGest(gesture:UIPinchGestureRecognizer){
        if let _=gesture.view{
            switch gesture.state {
            case .began:
                self.gravity.removeItem(gesture.view!)
            case .changed:
                if ((gesture.view?.layer.bounds.size.width)! * gesture.scale<limitSize && (gesture.view?.layer.bounds.size.width)! * gesture.scale>30){
                    self.collision.removeItem((gesture.view!))
                    self.elasticity.removeItem((gesture.view!))
                    
                    gesture.view?.layer.bounds.size.width *= gesture.scale
                    gesture.view?.layer.bounds.size.height *= gesture.scale
                    if let data=gesture.view as? Forme{
                        if !data.isRec{
                            gesture.view?.layer.cornerRadius *= gesture.scale
                        }
                    }
                    self.collision.addItem((gesture.view!))
                    self.elasticity.addItem((gesture.view!))
                }
                gesture.scale=1
                
            case .ended:
                self.gravity.addItem(gesture.view!)
            default:
                break
            }
        }
    }
    
    @objc func rotateGest(gesture:UIRotationGestureRecognizer){
        if let subview=gesture.view{
            switch gesture.state {
            case .began:
                view.bringSubviewToFront(subview)
                self.gravity.removeItem(subview)
            case .changed:
                collision.removeItem(subview)
                elasticity.removeItem(subview)
                
                subview.transform = view.transform.rotated(by: gesture.rotation)
                animator.updateItem(usingCurrentState: gesture.view!)
                
                elasticity.addItem(subview)
                collision.addItem(subview)
            case .ended:
                self.gravity.addItem(gesture.view!)
            default:
                break
            }
        }
    }
}

