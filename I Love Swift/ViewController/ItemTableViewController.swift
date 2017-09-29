//
//  ItemTableViewController.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/15.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit
import Font_Awesome_Swift

class ItemTableViewController: UITableViewController, NavBarViewDelegate {
    var sizeThatFitsTextView : CGSize!
    
    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
                  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
                  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
                  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
                  "Pear", "Pineapple", "Raspberry", "Strawberry"]
    
    var text = "只有一行"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableView.estimatedRowHeight = 120
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = fruits[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        
        cell.textLabel?.text = identifier
        
        if (indexPath.row == 2) {
            let settingsView = SettingsView(frame: CGRect(x: 0, y: 0, width: 300, height: 88))
            cell.addSubview(settingsView)
            settingsView.autoPinEdge(toSuperviewEdge: .top, withInset: 0.0)
            settingsView.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        }
        
        if (indexPath.row == 3) {
            let textView = UITextView(forAutoLayout: ())
            textView.backgroundColor = .green
            textView.text = text
            cell.addSubview(textView)
            textView.autoPinEdgesToSuperviewEdges()
            var cellSize = CGSize(width: Double.infinity, height: Double.infinity)
            cellSize.width = textView.frame.size.width
            sizeThatFitsTextView = textView.sizeThatFits(cellSize)
            print("sizeThatFitsTextView.height: \(sizeThatFitsTextView.height)")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 2) {
            return 400
        }
        
        if (indexPath.row == 3) {
            return sizeThatFitsTextView.height
        }
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            print("0")
            self.navigationController?.popViewController(animated: true)
        } else {
            let itemTableViewController = ItemTableViewController()
            itemTableViewController.fruits = []
            for index in 1...(indexPath.row+10) {
                itemTableViewController.fruits.append("Item \(index)")
            }
            itemTableViewController.tableView.reloadData()
            
            print("itemTableViewController.fruits:")
            print(itemTableViewController.fruits)

            self.navigationController?.pushViewController(
                itemTableViewController, animated: true)
        }
    }
    
    func onClickNavBarLeftButton() {
        print("click left button");
    }
    
    func onClickNavBarRightButton() {
        print("click right button");
    }
}
