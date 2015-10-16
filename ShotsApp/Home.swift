//
//  Home.swift
//  ShotsApp
//
//  Created by Junne on 10/15/15.
//  Copyright © 2015 Junne. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundMaskView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var popverView: UIView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favoriesLabel: UILabel!
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    
    var data = getData()
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        insertBlurView(backgroundMaskView, style: UIBlurEffectStyle.Dark)
//        insertBlurView(headerView, style: UIBlurEffectStyle.Dark)
        animator = UIDynamicAnimator(referenceView: view)
//        dialogView.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(Bool())
        
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        let translate = CGAffineTransformMakeTranslation(0, -200)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
        
        spring(0.5) {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
        }
        
        avatarImageView.image = UIImage(named: data[number]["avatar"]!)
        imageButton.setImage(UIImage(named: data[number]["image"]!), forState: UIControlState.Normal)
        backgroundImageView.image = UIImage(named: data[number]["image"]!)
        authorLabel.text = data[number]["author"]
        titleLabel.text = data[number]["title"]
        
        dialogView.alpha = 1
        
    }
    
    @IBAction func imageButtonDidPress(sender: AnyObject) {
        springWithCompletion(0.7, animations: {
            
            self.dialogView.frame = CGRectMake(0, 0, 600, 800)
            self.dialogView.layer.cornerRadius = 0
            self.imageButton.frame = CGRectMake(0, 0, 600, 240)
            self.likeButton.alpha = 0
            self.shareButton.alpha = 0
            self.userButton.alpha = 0
            self.headerView.alpha = 0
            
            }, completion: { finished in
                self.performSegueWithIdentifier("homeToDetail", sender: self)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "homeToDetail" {
            let controller = segue.destinationViewController as! Detail
            controller.data = data
            controller.number = number
        }
    }
    
    @IBAction func shareButtonPress(sender: AnyObject) {
        
        shareView.hidden = false
        showMask()
        shareView.transform = CGAffineTransformMakeTranslation(0, 200)
        emailButton.transform = CGAffineTransformMakeTranslation(0, 200)
        twitterButton.transform = CGAffineTransformMakeTranslation(0, 200)
        facebookButton.transform = CGAffineTransformMakeTranslation(0, 200)
        shareLabel.alpha = 0
        emailLabel.alpha = 0
        twitterLabel.alpha = 0
        facebookLabel.alpha = 0
        
        spring(0.5) {
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        }
        
        springWithDelay(0.5, delay: 0.05) { () -> Void in
            self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        
        springWithDelay(0.5, delay: 0.10) { () -> Void in
            self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        
        springWithDelay(0.5, delay: 0.15) { () -> Void in
            self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        
        springWithDelay(0.5, delay: 0.2) { () -> Void in
            self.shareLabel.alpha = 1
            self.emailLabel.alpha = 1
            self.twitterLabel.alpha = 1
            self.facebookLabel.alpha = 1
        }
    }
    
    @IBAction func userButtonDidPress(sender: AnyObject) {
        popverView.hidden = false
        
        let scale = CGAffineTransformMakeScale(0.3, 0.3)
        let translate = CGAffineTransformMakeTranslation(50, -50)
        popverView.transform = CGAffineTransformConcat(scale, translate)
        popverView.alpha = 0
        
        showMask()
        
        spring(0.5) {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.popverView.transform = CGAffineTransformConcat(scale, translate)
            self.popverView.alpha = 1
        }
    }
    
    @IBAction func maskButtonDidPress(sender: AnyObject) {
        spring(0.5) {
            self.maskButton.alpha = 0
        }
        hideShareView()
        hidePopover()
    }
    
    func showMask() {
        self.maskButton.hidden = false
        self.maskButton.alpha = 0
        spring(0.5) {
            self.maskButton.alpha = 1
        }
    }
    
    func hideShareView() {
        spring(0.5) {
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
            self.shareView.hidden = true
        }
    }
    
    func hidePopover() {
        spring(0.5) {
            self.popverView.hidden = true
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravityBehaviour : UIGravityBehavior!
    var snapBehavior : UISnapBehavior!
    
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    @IBAction func handleGesture(sender: AnyObject) {
        
        let myView = dialogView
        let location = sender.locationInView(view)
        let boxLocation =  sender.locationInView(dialogView)
        
        if sender.state == UIGestureRecognizerState.Began {
            if snapBehavior != nil {
                animator.removeBehavior(snapBehavior)
            }
            
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(myView.bounds), boxLocation.y - CGRectGetMidY(myView.bounds))
            attachmentBehavior = UIAttachmentBehavior(item: myView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
        } else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = location
        } else if sender.state == UIGestureRecognizerState.Ended {
            animator.removeBehavior(attachmentBehavior)
            
            snapBehavior = UISnapBehavior(item: myView, snapToPoint: view.center)
            animator.addBehavior(snapBehavior)
            
            let translation = sender.translationInView(view)
            if translation.y > 100 {
                animator.removeAllBehaviors()
                let gravity = UIGravityBehavior(items: [dialogView])
                gravity.gravityDirection = CGVectorMake(0, 100)
                animator.addBehavior(gravity)
                
                delay(0.3) {
                    self.refreshView()
                }
            }
        }
        
    }
    
    func refreshView() {
        number++
        if number > 3 {
            number = 0
        }
        
        animator.removeAllBehaviors()
        
        snapBehavior = UISnapBehavior(item: dialogView, snapToPoint: view.center)
        attachmentBehavior.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidAppear(true)
    }
}
