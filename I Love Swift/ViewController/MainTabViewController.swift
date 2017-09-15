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
    var tableImage : UIImage!
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
        tableImage = UIImage.init(icon: .FATable, size: CGSize(width: 35, height: 35))
        let tabTwo = ItemTableViewController()
        let tabTwoBarItem = UITabBarItem(title: "Table", image: tableImage, tag: 2)
        
        tabTwo.tabBarItem = tabTwoBarItem
        
        // Create Tab third
        aboutImage = UIImage.init(icon: .FABars, size: CGSize(width: 35, height: 35))
        let tabThird = AboutViewController()
        let tabThirdBarItem = UITabBarItem(title: "About", image: aboutImage, tag: 3)
        
        tabThird.tabBarItem = tabThirdBarItem
        
        self.viewControllers = [tabOne, tabTwo, tabThird]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let title : String! = self.viewControllers?[self.selectedIndex].tabBarItem.title
        print(self.selectedIndex);
        print("title:", title)
    }
}
