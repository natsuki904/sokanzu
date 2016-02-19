//
//  fourthViewController.swift
//  sokanzu
//
//  Created by USER on 2016/02/15.
//  Copyright © 2016年 Natsuki Teruya. All rights reserved.
//

import UIKit
import Social

class fourthViewController: UIViewController {

    

    @IBOutlet weak var textField1: UILabel!
    @IBOutlet weak var textField2: UILabel!
    @IBOutlet weak var comment1: UITextView!
    @IBOutlet weak var comment2: UITextView!
    @IBOutlet weak var relationshipUp: UILabel!
    @IBOutlet weak var relationshipDown: UILabel!
    @IBOutlet weak var memberNumber: UILabel!
    @IBOutlet weak var image1: UIImageView!
    

    
    @IBAction func tapShare(sender: UIButton) {
        var twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterVC.setInitialText("iphoneアプリ開発中なu")
        //message表示
        presentViewController(twitterVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //一人目の名前
        var myDefault = NSUserDefaults.standardUserDefaults()
        var myStr:String = myDefault.stringForKey("myString")!
        textField1.text = myStr
        
        //写真
        var myDefault2 = NSUserDefaults.standardUserDefaults()
        var myStr2:String = myDefault2.stringForKey("myImg")!
        image1.image = UIImage(named: myStr2)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
