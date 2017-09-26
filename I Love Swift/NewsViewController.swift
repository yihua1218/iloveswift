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
        let newsView : NewsView = NewsView()
        
        newsView.centerButton.addTarget(self, action: #selector(clickedButton(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view = newsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // self.view.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func clickedButton(sender: AnyObject) {
        print("centerButton clicked")
        self.navigationController?.pushViewController(
            ItemTableViewController(), animated: true)
    }
}
