//
//  ViewController.swift
//  sokanzu
//
//  Created by USER on 2016/02/15.
//  Copyright © 2016年 Natsuki Teruya. All rights reserved.
//

import UIKit
import iAd


class ViewController: UIViewController,UIViewControllerTransitioningDelegate {



    @IBOutlet weak var myTitle: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var myiAd: ADBannerView!

    
    
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

        self.canDisplayBannerAds = true
        

        //広告
        self.myiAd.hidden = true

    }
    
    @IBAction func boomAction(sender: AnyObject) {
        //view.boom()
        (sender as! UIButton).enabled = false
        delay(0, task: {self.startBtn.boom()})

        let secondVC:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "one" )
        self.presentViewController( secondVC as! UIViewController, animated: true, completion: nil)

    }
    

    typealias Task = (cancel : Bool) -> ()
    
    func delay(time:NSTimeInterval, task:()->()) ->  Task? {
        
        func dispatch_later(block:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(time * Double(NSEC_PER_SEC))),
                dispatch_get_main_queue(),
                block)
        }
        
        var closure: dispatch_block_t? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure);
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        }
        
        return result;
    }
    
    func cancel(task:Task?) {
        task?(cancel: true)
    }

    
    
    // バナーに広告が表示された時
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.myiAd.hidden = false
    }
    
    //バナーがクリックされた時
    func bannerViewActionShouldBegin(banner: ADBannerView!,willLeaveApplication willLeave: Bool) -> Bool {
        return willLeave
    }
    
    //広告表示にエラーが発生した場合
    func bannerView(banner:ADBannerView!,didFailToReceiveAdWithError:NSError!) {
        self.myiAd.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

