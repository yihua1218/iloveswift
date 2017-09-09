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
    var versionSubjectLabel : UILabel!
    var versionLabel : UILabel!
    var aboutTextView : UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.versionSubjectLabel = UILabel.newAutoLayout()
        self.versionSubjectLabel.text = "Versoin"
        self.versionSubjectLabel.textColor = UIColor.black
        self.versionSubjectLabel.layer.borderWidth  = 1
        
        self.versionLabel = UILabel.newAutoLayout()
        self.versionLabel.text = "1.0.0"
        self.versionLabel.textColor = UIColor.black
        self.versionLabel.layer.borderWidth  = 1
        
        self.aboutTextView = UITextView.newAutoLayout()
        self.aboutTextView.text = "This is a Swift example app for practicing and learning Swift."
        
        
        self.addSubview(self.versionSubjectLabel)
        self.addSubview(self.versionLabel)
        self.addSubview(self.aboutTextView)
        
        self.versionSubjectLabel.autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: 70.0)
        self.versionSubjectLabel.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 30.0)
        
        self.versionLabel.autoAlignAxis(ALAxis.horizontal, toSameAxisOf: self.versionSubjectLabel)
        self.versionLabel.autoPinEdge(toSuperviewEdge: ALEdge.right, withInset: 30.0)
        self.versionLabel.autoMatch(ALDimension.width, to: ALDimension.width, of: self.versionSubjectLabel, withMultiplier: 1.5)
        
        self.aboutTextView.autoPinEdge(ALEdge.left, to: ALEdge.left, of: self.versionSubjectLabel)
        self.aboutTextView.autoPinEdge(ALEdge.right, to: ALEdge.right, of: self.versionLabel)
        self.aboutTextView.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: self.versionSubjectLabel, withOffset: 10.0)
        self.aboutTextView.autoPinEdge(toSuperviewEdge: ALEdge.bottom)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

