//
//  ViewController.swift
//  sokanzu
//
//  Created by USER on 2016/02/15.
//  Copyright © 2016年 Natsuki Teruya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate {



    @IBOutlet weak var myTitle: UIImageView!
    @IBOutlet weak var startBtn: ZFRippleButton!
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //      保存データを全削除
        let userDefault = NSUserDefaults.standardUserDefaults()
        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!; NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
        
        myTitle.image = UIImage(named: "半沢風.jpg")
        
        self.startBtn.layer.cornerRadius = 5
        
        
        //AppDelegateにアクセスするための準備をして
        var myAp = UIApplication.sharedApplication().delegate as! AppDelegate
        //プロパティの値を書き換える
        myAp.myCount = 0

    }
    
    
    let transition = BubbleTransition()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = startBtn.center
        transition.bubbleColor = startBtn.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = startBtn.center
        transition.bubbleColor = startBtn.backgroundColor!
        return transition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

