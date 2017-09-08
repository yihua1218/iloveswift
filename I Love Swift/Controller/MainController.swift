//
//  MainController.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/8.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit

class MainController: UIViewController {
    var aboutView : AboutView!

    override func loadView() {
        self.view = AboutView()
        
        super.loadView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        aboutView = AboutView(frame: CGRect.zero)
        self.view.addSubview(aboutView)
        
        // AutoLayout
        aboutView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
