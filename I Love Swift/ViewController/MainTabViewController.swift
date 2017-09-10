//
//  NewsViewController.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/10.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit
import Font_Awesome_Swift

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {
    var newsImage : UIImage!
    var aboutImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        newsImage = UIImage.init(icon: .FANewspaperO, size: CGSize(width: 35, height: 35))
        let tabOne = NewsViewController()
        let tabOneBarItem = UITabBarItem(title: "News", image: newsImage, tag: 1)
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        aboutImage = UIImage.init(icon: .FABars, size: CGSize(width: 35, height: 35))
        let tabTwo = AboutViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "About", image: aboutImage, tag: 2)
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let title : String! = self.viewControllers?[self.selectedIndex].tabBarItem.title
        print(self.selectedIndex);
        print("title:", title)
    }
}
