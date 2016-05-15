//
//  Kiosk.swift
//
//  Created by David House on 11/25/15.
//  Copyright © 2016 David House. All rights reserved.
//

import UIKit

/// Enumeration of the keys used in user defaults to hold the settings
enum KioskSettingsKeys:String {
    case KioskEnabled = "KioskEnabled"
    case KioskTargetScheme = "KioskTargetScheme"
    case KioskInterval = "KioskInterval"
}

/// Enumeration for the kiosk interval setting
enum KioskInterval:String {
    case FifteenSeconds = "15 seconds"
    case ThirtySeconds = "30 seconds"
    case OneMinute = "1 minute"
    case TwoMinutes = "2 minutes"
    case ThreeMinutes = "3 minutes"
    case FourMinutes = "4 minutes"
    case FiveMinutes = "5 minutes"
    case TenMinutes = "10 minutes"
    case FifteenMinutes = "15 minutes"
    case ThirtyMinutes = "30 minutes"
    case OneHour = "1 mour"
}

/// The Kiosk class, responsible for opening another app on an interval
class Kiosk : NSObject {
    
    // MARK: Properties
    
    var changeTimer:NSTimer?
    var enabled:Bool?
    var targetURLScheme:String?
    var interval:String?
    
    // MARK: Initializer
    
    /// Initialize with an optional user defaults object
    init(defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()) {
        
        self.enabled = defaults.boolForKey(KioskSettingsKeys.KioskEnabled.rawValue)
        self.targetURLScheme = defaults.stringForKey(KioskSettingsKeys.KioskTargetScheme.rawValue)
        self.interval = defaults.stringForKey(KioskSettingsKeys.KioskInterval.rawValue)
    }
    
    // MARK: Public Methods
    
    /// Start the Kiosk timer
    func start() {
        
        if let enabled = enabled where enabled == true {
            if let interval = intervalFromString(interval) {
                changeTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: #selector(switchToNextApp), userInfo: nil, repeats: false)
            }
            else {
                print( "KIOSK ERROR: Unable to determine interval from value \(interval)")
            }
        }
    }
    
    /// Stop the Kiosk timer
    func stop() {
        
        if let timer = changeTimer {
            timer.invalidate()
        }
    }
    
    // MARK: Private methods
    
    /// Called from timer when Kiosk should switch to the next app
    @objc private func switchToNextApp() {
        
        guard let scheme = targetURLScheme else {
            print("Kiosk Error: Target URL scheme not supplied. Unable to switch apps")
            return
        }
        
        guard let url = NSURL(string: "\(scheme)://open") else {
            print("Kiosk Error: Unable to create url from target scheme. Tried \(scheme)://open")
            return
        }
        
        guard UIApplication.sharedApplication().canOpenURL(url) else {
            print("Kiosk Error: Failed to validate url: \(scheme)://open, make sure you have this URL scheme specified in the target application AND in this applications LSApplicationQueriesSchemes info.plist setting. Also the target application should be installed.")
            return
        }
        
        if !UIApplication.sharedApplication().openURL(url) {
            print("Kiosk Error: Failed to open url: \(scheme)://open, make sure you have this URL scheme specified in the target application AND in this applications LSApplicationQueriesSchemes info.plist setting")
        }        
    }
    
    /// Convert a String into a NSTimeInterval
    ///
    /// - parameter interval: A String
    private func intervalFromString(interval:String?)  -> NSTimeInterval? {
        
        if let intervalValue = KioskInterval(rawValue: interval ?? "1 Minute") {
            switch (intervalValue) {
            case .FifteenSeconds:
                return 15
            case .ThirtySeconds:
                return 30
            case .OneMinute:
                return 60
            case .TwoMinutes:
                return 120
            case .ThreeMinutes:
                return 180
            case .FourMinutes:
                return 240
            case .FiveMinutes:
                return 300
            case .TenMinutes:
                return 600
            case .FifteenMinutes:
                return 900
            case .ThirtyMinutes:
                return 1800
            case .OneHour:
                return 3600
            }
        }
        else {
            return 60
        }
    }
}
