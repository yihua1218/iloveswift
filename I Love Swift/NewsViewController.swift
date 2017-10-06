//
//  MainController.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/8.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    let newsView : NewsView = NewsView()
    let notificationKey = "tw.idv.hoebus.swift"
        

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view, typically from a nib.
        newsView.centerButton.addTarget(self, action: #selector(clickedButton(sender:)), for: UIControlEvents.touchUpInside)
        newsView.notificationButton.addTarget(self, action: #selector(sendNotificatonButton(sender:)), for: UIControlEvents.touchUpInside)
        
        view = newsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // self.view.center
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name(rawValue: notificationKey), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func clickedButton(sender: AnyObject) {
        print("centerButton clicked")
        let itemTableViewController = ItemTableViewController()
        itemTableViewController.text = newsView.textView.text
        itemTableViewController.fruits[0] = newsView.textView.text
        navigationController?.pushViewController(
            itemTableViewController, animated: true)
    }
    
    @objc func sendNotificatonButton(sender: AnyObject) {
        print("sendNotificatoinButton clicked")
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: self)
    }
    
    @objc func receivedNotification() {
        newsView.textView.text = "收到通知"
    }
}
