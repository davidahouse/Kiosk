//
//  AppDelegate.swift
//  KioskApp2
//
//  Created by David House on 4/24/16.
//  Copyright © 2016 David House. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var kiosk: Kiosk?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        // start the kiosk timer so we will switch at the appropriate time
        kiosk = Kiosk()
        kiosk!.start()
    }
}
