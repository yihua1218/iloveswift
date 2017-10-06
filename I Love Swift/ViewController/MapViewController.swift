//
//  MapViewController.swift
//  I Love Swift
//
//  Created by 梁益華 on 2017/9/18.
//  Copyright © 2017年 Yi-Hua Liang. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import PureLayout

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var notificationLabel: UILabel!
    var notificationButton : UIButton!
    let notificationKey = "tw.idv.hoebus.swift"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name(rawValue: notificationKey), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView = MKMapView.init(forAutoLayout: ())
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
        mapView.autoPinEdgesToSuperviewEdges()
        
        notificationLabel = UILabel.newAutoLayout()
        notificationLabel.text = "等待通知"
        
        view.addSubview(notificationLabel)
        
        notificationLabel.autoCenterInSuperview()
        
        notificationButton = UIButton.newAutoLayout()
        notificationButton.setTitle("Send Notification", for: UIControlState.normal);
        notificationButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        notificationButton.backgroundColor = .clear
        notificationButton.layer.cornerRadius = 5
        notificationButton.layer.borderWidth = 1
        notificationButton.layer.borderColor = UIColor.black.cgColor
        
        view.addSubview(notificationButton)
        
        notificationButton.autoAlignAxis(ALAxis.vertical, toSameAxisOf: notificationLabel, withOffset: 0.0)
        notificationButton.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: notificationLabel, withOffset: 5.0)
        notificationButton.addTarget(self, action: #selector(sendNotificatonButton(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    @objc func sendNotificatonButton(sender: AnyObject) {
        print("sendNotificatoinButton clicked")
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: self)
    }
    
    @objc func receivedNotification() {
        notificationLabel.text = "收到通知"
    }
}
