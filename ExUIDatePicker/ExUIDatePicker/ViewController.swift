//
//  ViewController.swift
//  ExUIDatePicker
//
//  Created by User11 on 2018/6/23.
//  Copyright © 2018年 WilhelmShen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 取得螢幕的尺寸
    let fullScreenSize = UIScreen.main.bounds.size
    
    var myDatePicker: UIDatePicker!
    var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    
            //创建日期选择器
            let datePicker = UIDatePicker(frame: CGRect(x:0, y:0, width:320, height:216))
            //将日期选择器区域设置为中文，则选择器日期显示为中文
            datePicker.locale = Locale(identifier: "zh_CN")
            //注意：action里面的方法名后面需要加个冒号“：”
            datePicker.addTarget(self, action: #selector(dateChanged),
                                 for: .valueChanged)
            self.view.addSubview(datePicker)
        }
        
        //日期选择器响应方法
        func dateChanged(datePicker : UIDatePicker){
            //更新提醒时间文本框
            let formatter = DateFormatter()
            //日期样式
            formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
            print(formatter.string(from: datePicker.date))
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
        
    
    

}

