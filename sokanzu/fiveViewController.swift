//
//  fiveViewController.swift
//  sokanzu
//
//  Created by USER on 2016/02/22.
//  Copyright © 2016年 Natsuki Teruya. All rights reserved.
//

import UIKit
import Social
import Photos


class fiveViewController: UIViewController {


    @IBOutlet weak var textField1: UILabel!
    @IBOutlet weak var textField2: UILabel!
    @IBOutlet weak var textField3: UILabel!
    @IBOutlet weak var comment1: UITextView!
    @IBOutlet weak var comment2: UITextView!
    @IBOutlet weak var comment3: UITextView!
    @IBOutlet weak var relationshipRight: UILabel!
    @IBOutlet weak var relationshipMiddle: UILabel!
    @IBOutlet weak var relationshipLeft: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var memberNumber:Int = 0
    
    
    
    @IBAction func tapShare(sender: UIButton) {
        var twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterVC.setInitialText("iphoneアプリ開発中なu")
        //message表示
        presentViewController(twitterVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ユーザーデフォルトの読み込み
        var myDefault = NSUserDefaults.standardUserDefaults()
        var myStr:Array = myDefault.arrayForKey("myString2")!
        var member1 = myStr[0]["name"]
        var member2 = myStr[1]["name"]
        var member3 = myStr[2]["name"]
        var imageStr1 = myStr[0]["image"]
        var imageStr2 = myStr[1]["image"]
        var imageStr3 = myStr[2]["image"]
        
        //一人目の名前
        textField1.text = member1 as! String
        //二人目の名前
        textField2.text = member2 as! String
        //三人目の名前
        textField3.text = member3 as! String
        
        
        //      assetURLの読み込み
        var imageURL1 = NSURL(string: imageStr1 as! String)!
        var imageURL2 = NSURL(string: imageStr2 as! String)!
        var imageURL3 = NSURL(string: imageStr3 as! String)!
        //      一人目の写真
        let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([imageURL1], options: nil)
        let asset: PHAsset = fetchResult.firstObject as! PHAsset
        let manager: PHImageManager = PHImageManager()
        manager.requestImageForAsset(asset,
            targetSize: CGSizeMake(100, 100),
            contentMode: .AspectFill,
            options: nil) { (image, info) -> Void in
                
                self.image1.image = image
        }
        //       二人目の写真
        let fetchResult2: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([imageURL2], options: nil)
        let asset2: PHAsset = fetchResult2.firstObject as! PHAsset
        let manager2: PHImageManager = PHImageManager()
        manager2.requestImageForAsset(asset2,
            targetSize: CGSizeMake(100, 100),
            contentMode: .AspectFill,
            options: nil) { (image, info) -> Void in
                
                self.image2.image = image
        }
        //       三人目の写真
        let fetchResult3: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([imageURL3], options: nil)
        let asset3: PHAsset = fetchResult3.firstObject as! PHAsset
        let manager3: PHImageManager = PHImageManager()
        manager3.requestImageForAsset(asset3,
            targetSize: CGSizeMake(100, 100),
            contentMode: .AspectFill,
            options: nil) { (image, info) -> Void in
                
                self.image3.image = image
        }

        
        //      保存データを全削除
        let userDefault = NSUserDefaults.standardUserDefaults()
        var appDomain:String = NSBundle.mainBundle().bundleIdentifier!; NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
    }
    
    
    override func viewWillAppear(animated: Bool){
        //-- json.txtファイルを読み込んで
        let path = NSBundle.mainBundle().pathForResource("json", ofType: "txt")
        let jsondata = NSData(contentsOfFile: path!)
        //-- 辞書データに変換して
        let jsonArray = (try! NSJSONSerialization.JSONObjectWithData(jsondata!, options: [])) as! NSArray
        
        var a = arc4random_uniform(4)
        var b = arc4random_uniform(4)
        var c = arc4random_uniform(4)
        var ransu1:Int = Int(a)
        print("a:\(ransu1)")
        var ransu2:Int = Int(b)
        print("b:\(ransu2)")
        var ransu3:Int = Int(c)
        print("c:\(ransu3)")
        
        let dic1 = jsonArray[ransu1]
        let dic2 = jsonArray[ransu2]
        let dic3 = jsonArray[ransu3]
        comment1.text = dic1["comment"] as! String
        comment2.text = dic2["comment"] as! String
        comment3.text = dic3["comment"] as! String
        relationshipRight.text = dic1["relationship"] as! String
        relationshipMiddle.text = dic2["relationship"] as!String
        relationshipLeft.text = dic3["relationship"] as! String
    }

    
    @IBAction func tapTop(sender: UIButton) {
        let fourVC:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "top" )
        self.presentViewController( fourVC as! UIViewController, animated: true, completion: nil)
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
