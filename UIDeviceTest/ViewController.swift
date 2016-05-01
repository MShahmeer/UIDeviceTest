//
//  ViewController.swift
//  UIDeviceTest
//
//  Created by Muhammad Athar on 01/05/2016.
//  Copyright © 2016 Muhammad Shahmeer Athar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var thisDevice: UIDevice = UIDevice.currentDevice()
    
    //Defining NSNotificationCentre Functions
    func batteryStateDidChange() {
        let newBatteryState = thisDevice.batteryState
        switch newBatteryState {
        case .Charging:
            deviceBatteryStateLabel.text = "Charging"
        case .Full:
            deviceBatteryStateLabel.text = "Full"
        case .Unknown:
            deviceBatteryStateLabel.text = "Unknown"
        case .Unplugged:
            deviceBatteryStateLabel.text = "Unplugged"
        }
    }
    
    func batteryLevelDidChange() {
        deviceBatteryLevelLabel.text = "\(Int(thisDevice.batteryLevel * 100))%"
    }
    
    func deviceRotated() {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            deviceOrientationLabel.text = "Landscape"
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            deviceOrientationLabel.text = "Portrait"
        }
    }
    
    func proximitySensorActivated() {
        if self.view.backgroundColor == UIColor.whiteColor() {
            self.view.backgroundColor = UIColor.blackColor()
        }
        else {
            self.view.backgroundColor = UIColor.whiteColor()
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.deviceRotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        thisDevice.batteryMonitoringEnabled = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.batteryStateDidChange), name: UIDeviceBatteryStateDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.batteryLevelDidChange), name: UIDeviceBatteryLevelDidChangeNotification, object: nil)
        
        thisDevice.proximityMonitoringEnabled = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.proximitySensorActivated), name: UIDeviceProximityStateDidChangeNotification, object: nil)
        if thisDevice.proximityMonitoringEnabled == true {
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
        case .Charging:
            deviceBatteryStateLabel.text = "Charging"
        case .Full:
            deviceBatteryStateLabel.text = "Full"
        case .Unknown:
            deviceBatteryStateLabel.text = "Unknown"
        case .Unplugged:
            deviceBatteryStateLabel.text = "Unplugged"
        }
        
        super.viewDidLoad()
    }
}

