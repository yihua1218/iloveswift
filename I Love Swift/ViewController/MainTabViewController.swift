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
        tabs["News"]!["tag"] = 1
        
        tabs["Map"] = [String: Any]()
        tabs["Map"]!["icon"] = FAType.FAMap.rawValue
        tabs["Map"]!["size"] = CGSize(width: 35, height: 35)
        tabs["Map"]!["title"] = "Map"
        tabs["Map"]!["vc"] = MapViewController()
        tabs["Map"]!["tag"] = 2
        
        tabs["Table"] = [String: Any]()
        tabs["Table"]!["icon"] = FAType.FATable.rawValue
        tabs["Table"]!["size"] = CGSize(width: 35, height: 35)
        tabs["Table"]!["title"] = "Table"
        
        let itemTableViewController = ItemTableViewController()
        let navigationBarView = NavigationBarView(leftFA: FAType.FAArrowLeft.rawValue, title: "Table View", rightFA: FAType.FAWindowClose.rawValue)
        let navigationController = UINavigationController.init(rootViewController: itemTableViewController)
        navigationController.view.addSubview(navigationBarView)
        tabs["Table"]!["vc"] = navigationController
        
        tabs["Table"]!["tag"] = 3
        
        tabs["About"] = [String: Any]()
        tabs["About"]!["icon"] = FAType.FABars.rawValue
        tabs["About"]!["size"] = CGSize(width: 35, height: 35)
        tabs["About"]!["title"] = "About"
        tabs["About"]!["vc"] = AboutViewController()
        tabs["About"]!["tag"] = 4
        
        var viewControllers = [UIViewController]()
        for (tab_id, tab_def) in tabs {
            let tag = tabs[tab_id]!["tag"] as? Int
            let vc = tabs[tab_id]!["vc"] as? UIViewController
            let title = tab_def["title"]
            print("\(tab_id) => \(title ?? 0)")
            
            
            tabs[tab_id]!["image"] = UIImage.init(
                icon: FAType(rawValue: tab_def["icon"] as! Int)!,
                size: tab_def["size"] as! CGSize)
            
            tabs[tab_id]!["bar_item"] = UITabBarItem(
                title: title as? String,
                image: tabs[tab_id]!["image"] as? UIImage,
                tag: tag!)
            vc?.tabBarItem = tabs[tab_id]!["bar_item"] as? UITabBarItem
            viewControllers.append(vc!)
        }
        
        let result : [UIViewController] = viewControllers.sorted {
            switch ($0.tabBarItem.tag, $1.tabBarItem.tag) {
            case (nil, nil), (_, nil):
                return true
            case (nil, _):
                return false
            case let (lhs, rhs):
                return lhs < rhs
            }
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.viewControllers = result
        print(self.viewControllers!)
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let title : String! = self.viewControllers?[self.selectedIndex].tabBarItem.title
        print(self.selectedIndex);
        print("title:", title)
    }
}
