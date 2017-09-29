//
//  SettingsView.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/29.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class SettingsView: UIView {
    let anchorView : UIView = UIView.newAutoLayout()
    let textView : UITextView = UITextView(forAutoLayout: ())
    let onOffLabel : UILabel = UILabel.newAutoLayout()
    let onOffSwitch : UISwitch = UISwitch()
    let alertOnOffLabel : UILabel = UILabel.newAutoLayout()
    let alertOnOffSwitch : UISwitch = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        anchorView.backgroundColor = .blue
        anchorView.autoSetDimensions(to: CGSize(width: 10, height: 10))
        addSubview(anchorView)
        // anchorView.autoPinEdge(toSuperviewEdge: .left)
        anchorView.autoPinEdge(toSuperviewEdge: .left)
        anchorView.autoPinEdge(toSuperviewEdge: .top)
        
        onOffLabel.text = "On / Off"
        onOffLabel.autoSetDimensions(to: CGSize(width: 160, height: 22))
        addSubview(onOffLabel)
        onOffLabel.autoPinEdge(ALEdge.left, to: ALEdge.right, of: anchorView, withOffset: 0.0)
        onOffLabel.autoPinEdge(ALEdge.top, to: .bottom, of: anchorView, withOffset: 0.0)
        
        textView.text = "1行\n兩行\n三行\n\n\n好幾行之後\n\n最後一行"
        // textView.autoSetDimensions(to: CGSize(width: 300, height: 200))
        // textView.autoSetDimension(ALDimension.height, toSize: 300.0)
        textView.backgroundColor = .yellow
        addSubview(textView)
        textView.autoPinEdge(ALEdge.left, to: ALEdge.left, of: onOffLabel, withOffset: 10.0)
        textView.autoPinEdge(ALEdge.top, to: .bottom, of: onOffLabel, withOffset: 10.0)
        textView.autoPinEdge(toSuperviewEdge: ALEdge.right, withInset: 10.0)
        
        addSubview(onOffSwitch)
        onOffSwitch.autoPinEdge(ALEdge.left, to: ALEdge.right, of: onOffLabel, withOffset: 100.0)
        onOffSwitch.autoPinEdge(ALEdge.top, to: ALEdge.top, of: onOffLabel, withOffset: 0.0)
        
        alertOnOffLabel.text = "Alert On / Off"
        alertOnOffLabel.autoSetDimensions(to: CGSize(width: 160, height: 22))
        addSubview(alertOnOffLabel)
        alertOnOffLabel.autoPinEdge(ALEdge.left, to: ALEdge.left, of: textView, withOffset: 0.0)
        alertOnOffLabel.autoPinEdge(ALEdge.top, to: .bottom, of: textView, withOffset: 10.0)

        addSubview(alertOnOffSwitch)
        alertOnOffSwitch.autoPinEdge(ALEdge.left, to: ALEdge.right, of: alertOnOffLabel, withOffset: 100.0)
        alertOnOffSwitch.autoPinEdge(ALEdge.top, to: ALEdge.top, of: alertOnOffLabel, withOffset: 0.0)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
