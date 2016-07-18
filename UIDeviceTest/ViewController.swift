//
//  ViewController.swift
//  UIDeviceTest
//
//  Created by Muhammad Athar on 01/05/2016.
//  Copyright © 2016 Muhammad Shahmeer Athar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var thisDevice: UIDevice = UIDevice.current()
    
    //Defining NSNotificationCentre Functions
    func batteryStateDidChange() {
        let newBatteryState = thisDevice.batteryState
        switch newBatteryState {
        case .charging:
            deviceBatteryStateLabel.text = "Charging"
        case .full:
            deviceBatteryStateLabel.text = "Full"
        case .unknown:
            deviceBatteryStateLabel.text = "Unknown"
        case .unplugged:
            deviceBatteryStateLabel.text = "Unplugged"
        }
    }
    
    func batteryLevelDidChange() {
        deviceBatteryLevelLabel.text = "\(Int(thisDevice.batteryLevel * 100))%"
    }
    
    func deviceRotated() {
        if(UIDeviceOrientationIsLandscape(UIDevice.current().orientation))
        {
            deviceOrientationLabel.text = "Landscape"
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current().orientation))
        {
            deviceOrientationLabel.text = "Portrait"
        }
    }
    
    func proximitySensorActivated() {
        if self.view.backgroundColor == UIColor.white() {
            self.view.backgroundColor = UIColor.black()
        }
        else {
            self.view.backgroundColor = UIColor.white()
        }
    }
    
    //Outlets
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceOSNameLabel: UILabel!
    @IBOutlet weak var deviceOSVersionLabel: UILabel!
    @IBOutlet weak var deviceModelLabel: UILabel!
    @IBOutlet weak var deviceBatteryLevelLabel: UILabel!
    @IBOutlet weak var deviceBatteryStateLabel: UILabel!
    @IBOutlet weak var deviceOrientationLabel: UILabel!
    @IBOutlet weak var proximitySensorAvailableLabel: UILabel!
    
    override func viewDidLoad() {
        
        //Notifications
        thisDevice.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(self.deviceRotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        thisDevice.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.batteryStateDidChange), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.batteryLevelDidChange), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        
        thisDevice.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.proximitySensorActivated), name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)
        if thisDevice.isProximityMonitoringEnabled == true {
            proximitySensorAvailableLabel.text = "Available"
        }
        else {
            proximitySensorAvailableLabel.text = "Unavailable"
        }
        
        //Setting the text to labels
        deviceNameLabel.text = thisDevice.name
        deviceOSNameLabel.text = thisDevice.systemName
        deviceOSVersionLabel.text = thisDevice.systemVersion
        deviceModelLabel.text = thisDevice.model
        deviceBatteryLevelLabel.text = "\(Int(thisDevice.batteryLevel * 100))%"
        
        switch thisDevice.batteryState {
        case .charging:
            deviceBatteryStateLabel.text = "Charging"
        case .full:
            deviceBatteryStateLabel.text = "Full"
        case .unknown:
            deviceBatteryStateLabel.text = "Unknown"
        case .unplugged:
            deviceBatteryStateLabel.text = "Unplugged"
        }
        
        super.viewDidLoad()
    }
}

