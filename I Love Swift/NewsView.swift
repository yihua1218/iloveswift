//
//  NewsView.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/10.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import PureLayout
import UIKit

class NewsView: UIView {
    var centerButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.centerButton = UIButton.newAutoLayout()
        self.centerButton.setTitle("Center Button", for: UIControlState.normal);
        self.centerButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.centerButton.backgroundColor = .clear
        self.centerButton.layer.cornerRadius = 5
        self.centerButton.layer.borderWidth = 1
        self.centerButton.layer.borderColor = UIColor.black.cgColor
        
        self.addSubview(self.centerButton)
        
        self.centerButton.autoCenterInSuperview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

