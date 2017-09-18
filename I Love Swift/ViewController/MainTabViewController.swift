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
        
        var tabs = [String:[String: Any]]()
        
        tabs["News"] = [String: Any]()
        tabs["News"]!["icon"] = FAType.FANewspaperO.rawValue
        tabs["News"]!["size"] = CGSize(width: 35, height: 35)
        tabs["News"]!["title"] = "News"
        tabs["News"]!["vc"] = NewsViewController()
        
        tabs["Map"] = [String: Any]()
        tabs["Map"]!["icon"] = FAType.FAMap.rawValue
        tabs["Map"]!["size"] = CGSize(width: 35, height: 35)
        tabs["Map"]!["title"] = "Map"
        tabs["Map"]!["vc"] = MapViewController()
        
        tabs["Table"] = [String: Any]()
        tabs["Table"]!["icon"] = FAType.FATable.rawValue
        tabs["Table"]!["size"] = CGSize(width: 35, height: 35)
        tabs["Table"]!["title"] = "Table"
        tabs["Table"]!["vc"] = ItemTableViewController()
        
        tabs["About"] = [String: Any]()
        tabs["About"]!["icon"] = FAType.FABars.rawValue
        tabs["About"]!["size"] = CGSize(width: 35, height: 35)
        tabs["About"]!["title"] = "About"
        tabs["About"]!["vc"] = AboutViewController()
        
        var viewControllers = [UIViewController]()
        var tag = 1
        for (tab_id, tab_def) in tabs {
            let vc = tabs[tab_id]!["vc"] as? UIViewController
            let title = tab_def["title"]
            print("\(tab_id) => \(title ?? 0)")
            
            
            tabs[tab_id]!["image"] = UIImage.init(
                icon: FAType(rawValue: tab_def["icon"] as! Int)!,
                size: tab_def["size"] as! CGSize)
            
            tabs[tab_id]!["bar_item"] = UITabBarItem(
                title: title as? String,
                image: tabs[tab_id]!["image"] as? UIImage,
                tag: tag)
            vc?.tabBarItem = tabs[tab_id]!["bar_item"] as? UITabBarItem
            print(vc!)
            viewControllers.append(vc!)
            tag += 1
        }
        self.viewControllers = viewControllers
        print(self.viewControllers!)

        /*
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
        
        self.viewControllers = [tabOne, tabTwo, tabThird]*/
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let title : String! = self.viewControllers?[self.selectedIndex].tabBarItem.title
        print(self.selectedIndex);
        print("title:", title)
    }
}
