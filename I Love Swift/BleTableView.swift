//
//  BleTableView.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/10/27.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import PureLayout
import UIKit
import Font_Awesome_Swift

class BleTableView: UITableView {
    var navigationBarView : NavigationBarView!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero, style: .grouped)
        self.navigationBarView = NavigationBarView(leftFA: FAType.FABars.rawValue, title: "Table View", rightFA: FAType.FABars.rawValue)
        print("addSubView: navigationBarView")
        self.addSubview(self.navigationBarView)
        
        refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(BleTableViewController.handleRefresh(_:)),
                                     for: UIControlEvents.valueChanged)
            refreshControl.tintColor = UIColor.red
            
            return refreshControl
        }()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

