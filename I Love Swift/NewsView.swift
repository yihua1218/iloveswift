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
    var notificationButton : UIButton!
    var textView : UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        centerButton = UIButton.newAutoLayout()
        centerButton.setTitle("Center Button", for: UIControlState.normal);
        centerButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        centerButton.backgroundColor = .clear
        centerButton.layer.cornerRadius = 5
        centerButton.layer.borderWidth = 1
        centerButton.layer.borderColor = UIColor.black.cgColor
        
        addSubview(centerButton)
        
        centerButton.autoCenterInSuperview()
        
        notificationButton = UIButton.newAutoLayout()
        notificationButton.setTitle("Send Notification", for: UIControlState.normal);
        notificationButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        notificationButton.backgroundColor = .clear
        notificationButton.layer.cornerRadius = 5
        notificationButton.layer.borderWidth = 1
        notificationButton.layer.borderColor = UIColor.black.cgColor
        
        addSubview(notificationButton)
        
        notificationButton.autoAlignAxis(ALAxis.vertical, toSameAxisOf: centerButton, withOffset: 0.0)
        notificationButton.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: centerButton, withOffset: 5.0)
        
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        textView.text = "隨便輸入幾行文字！"
        let fullScreenSize = UIScreen.main.bounds.size
        textView.center = CGPoint(
            x: fullScreenSize.width * 0.5,
            y: fullScreenSize.height * 0.3)
        
        addSubview(textView)        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

