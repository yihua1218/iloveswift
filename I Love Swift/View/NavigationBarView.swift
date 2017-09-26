//
//  NavigationBarView.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/22.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import PureLayout
import UIKit
import Font_Awesome_Swift

protocol NavBarViewDelegate: class {
    func onClickNavBarLeftButton()
    func onClickNavBarRightButton()
}

class NavigationBarView: UIView {
    var delegate: NavBarViewDelegate?
    var leftButton : UIButton!
    var rightButton : UIButton!
    var titleLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(leftFA: Int, title: String, rightFA: Int) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width, height: UIApplication.shared.statusBarFrame.height))
        self.backgroundColor = UIColor.green
        let leftImage = UIImage.init(
            icon: FAType(rawValue: leftFA)!,
            size: CGSize(width: 35, height: 35))
        
        let rightImage = UIImage.init(
            icon: FAType(rawValue: rightFA)!,
            size: CGSize(width: 35, height: 35))
        
        self.leftButton = UIButton.newAutoLayout()
        self.leftButton.setImage(leftImage, for: UIControlState.normal)
        self.leftButton.addTarget(self, action: #selector(clickLeft(sender:)), for: UIControlEvents.touchUpInside)
        
        self.titleLabel = UILabel.newAutoLayout()
        self.titleLabel.text = title

        self.rightButton = UIButton.newAutoLayout()
        self.rightButton.setImage(rightImage, for: UIControlState.normal)
        self.rightButton.addTarget(self, action: #selector(clickRight(sender:)), for: UIControlEvents.touchUpInside)
        

        self.addSubview(leftButton)
        self.addSubview(titleLabel)
        self.addSubview(rightButton)
        
        self.leftButton.autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: 5.0)
        self.leftButton.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 5.0)

        self.titleLabel.autoAlignAxis(toSuperviewAxis: ALAxis.vertical)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        
        self.rightButton.autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: 5.0)
        self.rightButton.autoPinEdge(toSuperviewEdge: ALEdge.right, withInset: 5.0)
        
        print(self.isUserInteractionEnabled)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func clickLeft(sender: AnyObject) {
        print("clickLeft")
        delegate?.onClickNavBarLeftButton()
    }
    
    @objc func clickRight(sender: AnyObject) {
        print("clickRight")
        delegate?.onClickNavBarRightButton()
    }
}
