//
//  ViewController.swift
//  00457149
//
//  Created by User16 on 2018/6/27.
//  Copyright © 2018年 User21. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgImageView.loadGif(name: "黑人問號")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

