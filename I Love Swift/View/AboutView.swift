//
//  AboutView.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/8.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import PureLayout
import UIKit

class AboutView: UIView {
    var label : UILabel!
    var versionSubjectLabel : UILabel!
    var versionLabel : UILabel!
    var aboutTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let x : CGFloat = 0.0
        let y : CGFloat = 0.0
        let width : CGFloat = 200.0
        let height : CGFloat = 50.0

        self.versionLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        self.versionLabel.text = "Versoin"
        self.versionLabel.textColor = UIColor.white
        self.versionLabel.layer.borderWidth  = 1
        
        self.aboutTextView = UITextView()
        
        
        self.addSubview(self.versionLabel!)
        
        self.versionLabel.autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: 70.0)
        self.versionLabel.autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: 30.0)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

