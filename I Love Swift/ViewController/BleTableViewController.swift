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

extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}

class BleTableViewController: UITableViewController, BleNavBarViewDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var sizeThatFitsTextView : CGSize!
    var timer : Timer!
    var myTracMo : CBPeripheral!
    var tracMoCmd: CBCharacteristic!
    var fruits = ["Scan", "Enable Notificatoin", "Restore", "Ring", "Stop Ring"]
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
        } else if (indexPath.row == 1) {
            print("enable notification")
            onClickEnableNotificationCell();
        } else if (indexPath.row == 2) {
            print("restore")
            onClickRestoreCell();
        } else if (indexPath.row == 3) {
            print("ring")
            onClickRingCell();
        } else if (indexPath.row == 4) {
            print("stop ring")
            onClickStopRingCell();
        } else {
            // tracMo Wallet: 0198467BE9
            print("Connect:", peripherals[indexPath.row-5].name ?? "Unknow")
            centralManager.connect(peripherals[indexPath.row-5], options: nil)
            myTracMo = peripherals[indexPath.row-5]
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
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
        peripheral.delegate = self
        for characteristic in service.characteristics! {
            print("characteristic for", service.uuid, ":", characteristic.uuid)
            peripheral.readValue(for: characteristic)
            
            // CB:
            if (characteristic.uuid.uuidString.isEqual("E8009A02-4143-5453-5162-6C696E6B73EC")) {
                print(characteristic.uuid, ": setNotifyValue: true")
                peripheral.setNotifyValue(true, for: characteristic)
            // BTM:
            } else if (characteristic.uuid.uuidString.isEqual("E8009A03-4143-5453-5162-6C696E6B73EC")) {
                print(characteristic.uuid, ": setNotifyValue: true")
                peripheral.setNotifyValue(true, for: characteristic)
            // CMD:
            } else if (characteristic.uuid.uuidString.isEqual("E8009A01-4143-5453-5162-6C696E6B73EC")) {
                tracMoCmd = characteristic
            } else {
                print(characteristic.uuid, ": not matched")
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        print(characteristic.uuid, ":", characteristic.value ?? "null")
        let data = characteristic.value
        if (data != nil) {
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            print(characteristic.uuid, ":", dataString ?? "nil")
        }
        
        if (characteristic.uuid.uuidString.isEqual("E8009A02-4143-5453-5162-6C696E6B73EC")) {
            print("Callback: \(data! as NSData)")
            let data = Data(hexString: "2f1f")
            myTracMo.writeValue(data!, for: tracMoCmd, type: CBCharacteristicWriteType.withoutResponse)
        } else if (characteristic.uuid.uuidString.isEqual("E8009A03-4143-5453-5162-6C696E6B73EC")) {
            print("Callback: \(data! as NSData)")
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
            print("didDiscover:", advertisementData)
            fruits.append(advertisementData["kCBAdvDataLocalName"] as! String)
            peripherals.append(peripheral)
            // tableView.reloadData()
        }
        
        /* let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as! NSData
        if (manufacturerData === nil || manufacturerData.length < 8) {
            return
            
        } */
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        print("didWriteValueFor:", characteristic.value)
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
        fruits = ["Scan", "Enable Notificatoin", "Restore", "Ring", "Stop Ring"]
        peripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(stopScan), userInfo: nil, repeats: false)
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    @objc func onClickEnableNotificationCell() {
        print("Click enable notificaiton")
    }

/*
 #define QPS_Q1_SERVICE_UUID         @"E8008802-4143-5453-5162-6C696E6B73EC"
 #define QPS_Q1_CMD_UUID             @"E8009A01-4143-5453-5162-6C696E6B73EC"
 #define QPS_Q1_CB_UUID              @"E8009A02-4143-5453-5162-6C696E6B73EC"
 #define QPS_Q1_BTN_UUID             @"E8009A03-4143-5453-5162-6C696E6B73EC"
 #define QBLINKS_INFO_UUID           @"180A"
 #define QBLINKS_SYSTEM_ID_UUID      @"2A23"
 #define QBLINKS_MANUFACTURER_UUID   @"2A29"
 */
    @objc func onClickRestoreCell() {
        print("Click Restore")
        let QPS_Q1_SERVICE_UUID =
            CBUUID(string: "E8008802-4143-5453-5162-6C696E6B73EC")
        peripherals = centralManager.retrieveConnectedPeripherals(withServices: [QPS_Q1_SERVICE_UUID])
        
        if (peripherals.count > 0) {
            print(peripherals)
            myTracMo = peripherals[0]
            centralManager.connect(myTracMo, options: nil)
        }
    }

    @objc func onClickRingCell() {
        print("Click Ring")
        let data = Data(hexString: "3003068403")
        myTracMo.writeValue(data!, for: tracMoCmd, type: CBCharacteristicWriteType.withResponse)
    }

    @objc func onClickStopRingCell() {
        print("Click Stop Ring")
        let data = Data(hexString: "3004")
        myTracMo.writeValue(data!, for: tracMoCmd, type: CBCharacteristicWriteType.withResponse)
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

