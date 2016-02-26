//
//  thirdViewController.swift
//  sokanzu
//
//  Created by USER on 2016/02/15.
//  Copyright © 2016年 Natsuki Teruya. All rights reserved.
//

import UIKit

class  thirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var thirdView: UIView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var memberName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    
    var memberNumber:Int = 0
    var str:String = ""
    var str2:String = ""
    var inputFlg = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "noImage.png")!
        str = String(memberNumber)
        print(str)
        var myAp = UIApplication.sharedApplication().delegate as! AppDelegate
        var myAp2 = myAp.myCount+1
        var myAp3:String = String(myAp2)
        number.text = myAp3
        str2 = memberName.text!

    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var textFieldString = textField.text! as NSString
        textFieldString = textFieldString.stringByReplacingCharactersInRange(range, withString: string)
        if memberName.text == "" {
            // textFieldが空のとき
            // myButtonを使用不可に
            nextBtn.enabled = false
            self.inputFlg = false
        }else{
            // textFieldに1文字でも入力されているとき
            // myButtonを使用可能に
            nextBtn.enabled = true
            self.inputFlg = true
        }
        // ↓trueを返すことで入力が確定する
        return true
    }
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        // フォトライブラリを使用できるか確認
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            // フォトライブラリの画像・写真選択画面を表示
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .PhotoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            presentViewController(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        
//        if imageView.image == nil {
//            nextBtn.enabled = false
//        } else {
//            nextBtn.enabled = true
//        }

        
        // 選択した画像・写真を取得し、imageViewに表示
        if let info = editingInfo, let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            imageView.image = editedImage
        }else{
            imageView.image = image
        }
        
        // フォトライブラリの画像・写真選択画面を閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        
        let assetURL:AnyObject = editingInfo![UIImagePickerControllerReferenceURL]!
        let url = NSURL(string: assetURL.description)
        
      
        //ユーザーデフォルトを用意する
        var myDefault = NSUserDefaults.standardUserDefaults()
        
        var peopleList:[NSDictionary] = []
        
        if myDefault.arrayForKey("myString2") != nil {
            var myStr:Array = myDefault.arrayForKey("myString2")!
            
            
            if myStr.count > 0 {
                peopleList = myStr as! NSArray as! [NSDictionary]
            }
        
        }
        
        var data:NSDictionary = ["name":memberName.text!, "image":assetURL.description]
        peopleList.append(data)
        print(peopleList)
        
        
        //データを書き込んで
        myDefault.setObject(peopleList, forKey: "myString2")
        //即反映させる
        myDefault.synchronize()

    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.inputFlg = false
        var myAp = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if str == "3" {
            if myAp.myCount == 2{
                // 非表示
                self.nextBtn.hidden = true
                self.createBtn.hidden = false
            }else{
                // 表示
                self.nextBtn.hidden = false
                self.createBtn.hidden = true
                
            }
        }
        if str == "2" {
            if myAp.myCount == 1{
                // 非表示
                self.nextBtn.hidden = true
                self.createBtn.hidden = false
            }else{
                // 表示
                self.nextBtn.hidden = false
                self.createBtn.hidden = true
                
            }
        }
    }
    
    
    @IBAction func tapNext(sender: UIButton) {
        if memberName.text == "" || imageView.image == "noImage.png" {
            nextBtn.enabled = false
        } else {
            nextBtn.enabled = true
        }
    }
    

    @IBAction func tapCreate(sender: UIButton) {
        
        if memberName.text == "" || imageView.image == "noImage.png" {
            nextBtn.enabled = false
        } else {
            nextBtn.enabled = true
        }
                
        if self.inputFlg {
            if str == "2" {
                let fourVC:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "two" )
                self.presentViewController( fourVC as! UIViewController, animated: true, completion: nil)
            } else if str == "3" {
                let fiveVC:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "three" )
                self.presentViewController( fiveVC as! UIViewController, animated: true, completion: nil)
                
            }
        } else {
//            createBtn.setTitle("文字を入力してね", forState: UIControlState.Normal)
            //アラートをつくる
            var alertController = UIAlertController(
                title: "注意",
                message: "ちゃんと名前と写真を選びなさいよ。",
                preferredStyle: .Alert)
            //OKボタンを追加
            alertController.addAction(UIAlertAction(
                title: "わかった",
                style: .Default,
                handler: {action in print("わかった") }))
            //アラートを表示する
            presentViewController(alertController,
                animated: true,
                completion: nil)

        }
        
    }
    
    // Segueで画面遷移する時
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showThirdView" {
            var thirdVC = segue.destinationViewController as! thirdViewController
            
            //AppDelegateにアクセスするための準備をして
            var myAp = UIApplication.sharedApplication().delegate as! AppDelegate
            //プロパティの値を書き換える
            myAp.myCount++
            print(myAp.myCount)
        
            //何人目か
            var memberNumberInt:Int = memberNumber
            thirdVC.memberNumber = memberNumberInt
        }
        
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
