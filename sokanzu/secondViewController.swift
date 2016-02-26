//
//  ViewController.swift
//  samplePickerView
//
//  Created by USER on 2016/01/28.
//  Copyright © 2016年 Natsuki Teruya. All rights reserved.
//

import UIKit

class secondViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var myPicker: UIPickerView!
    //何も指定されてない時
    var row:Int? = -1
    
    
    //データを配列で用意する
    var  dataArray:[Int] = ([Int])(2...3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.row = 0
        
    }
    //  ピッカービューの行数(1列）
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //ピッカービューの行数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    //ピッカービューに表示する文字（tea_list配列の値）
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(dataArray[row]) + "人"    }
    //ピッカービューで選択された時に行う処理
    func pickerView(pickerView: UIPickerView, var didSelectRow row: Int, inComponent component: Int){
        self.row = row
        
    }
    
    
    // Segueで画面遷移する時
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var thirdVC = segue.destinationViewController as! thirdViewController
        
        var memberNumberInt:Int = dataArray[self.row!]
        
        thirdVC.memberNumber = memberNumberInt
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

