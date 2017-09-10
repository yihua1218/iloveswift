//
//  MainController.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/8.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = NewsView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
