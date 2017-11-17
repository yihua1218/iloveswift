//
//  BleTableViewController.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/10/27.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit
import Font_Awesome_Swift
import CoreBluetooth

class BleTableViewController: UITableViewController, BleNavBarViewDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var sizeThatFitsTextView : CGSize!
    var timer : Timer!
    
    var fruits = ["Scan"]
    var peripherals = [CBPeripheral]()
    
    var text = "只有一行"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.estimatedRowHeight = 120
        let queue = DispatchQueue(label: "beeee")
        centralManager = CBCentralManager(delegate: self, queue: queue)
        centralManager.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: "refresh:", for: UIControlEvents.valueChanged)
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            print("scan cell")
            onClickNavBarRightButton();
            // self.navigationController?.popViewController(animated: true)
        } else {
            // 7BE9
            print("Connect:", peripherals[indexPath.row-1].name ?? "Unknow")
            centralManager.connect(peripherals[indexPath.row-1], options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnect:", peripheral.name ?? "Unknow");
        // https://www.bluetooth.com/specifications/gatt/services
        print("peripheral:", peripheral.identifier)
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices:", peripheral.name ?? "Unknow");
        for service:CBService in peripheral.services as [CBService]! {
            print("service.uuid:", service.uuid)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            print("characteristic for", service.uuid, ":", characteristic.uuid)
        }
    }
    
    func onClickNavBarLeftButton() {
        print("click left button");
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("central status: %@", central)
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print("willRestoreState")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (( advertisementData["kCBAdvDataLocalName"]) != nil) {
            peripheral.delegate = self
            print("didDiscover: %@", advertisementData)
            fruits.append(advertisementData["kCBAdvDataLocalName"] as! String)
            peripherals.append(peripheral)
            // tableView.reloadData()
        }
        
        /* let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as! NSData
        if (manufacturerData === nil || manufacturerData.length < 8) {
            return
            
        } */
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(stopScan), userInfo: nil, repeats: false)
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        print("Scanning...")
    }
    
    @objc func onClickNavBarRightButton() {
        print("Scanning...")
        fruits = ["Scan"]
        peripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(stopScan), userInfo: nil, repeats: false)
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func stopScan() {
        centralManager.stopScan()
        print("stop scan")
        print(fruits)
        tableView.reloadData()
    }
}

