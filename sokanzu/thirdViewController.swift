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
    
    var memberNumber:Int = 0
    var str:String = ""
    var str2:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "test.jpg")
        str = String(memberNumber)
        print(str)
        number.text = "1"
        str2 = memberName.text!

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
        var myDefault2 = NSUserDefaults.standardUserDefaults()
        //データを書き込んで
        myDefault2.setObject(assetURL.description, forKey: "myImg")
        //即反映させる
        myDefault2.synchronize()
    }
    
    
    @IBAction func tapNext(sender: UIButton) {
        //ユーザーデフォルトを用意する
        var myDefault = NSUserDefaults.standardUserDefaults()
        //データを書き込んで
        myDefault.setObject(memberName.text, forKey: "myString")
        //即反映させる
        myDefault.synchronize()
        
    }

//    func reloadPage(sender: UIBarButtonItem) {
//        self.thirdView.reload()
//    }



//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
//        
//        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]!
//        let url = NSURL(string: assetURL.description)
//        
//        //ユーザーデフォルトを用意する
//        var myDefault2 = NSUserDefaults.standardUserDefaults()
//        //データを書き込んで
//        myDefault2.setObject(info, forKey: "myImg")
//        //即反映させる
//        myDefault2.synchronize()
//        
//        
//    }
    
    
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
