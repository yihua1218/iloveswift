//
//  ItemTableView.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/15.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import PureLayout
import UIKit

class ItemTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }

    convenience init() {
        self.init(frame: CGRect.zero, style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
