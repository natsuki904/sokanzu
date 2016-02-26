//
//  ViewController.swift
//  sokanzu
//
//  Created by USER on 2016/02/15.
//  Copyright © 2016年 Natsuki Teruya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var myTitle: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTitle.image = UIImage(named: "半沢風.jpg")
        
        self.startBtn.layer.cornerRadius = 10
        
        
        //AppDelegateにアクセスするための準備をして
        var myAp = UIApplication.sharedApplication().delegate as! AppDelegate
        //プロパティの値を書き換える
        myAp.myCount = 0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

