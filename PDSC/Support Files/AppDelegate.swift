//
//  AppDelegate.swift
//  PDSC
//
//  Created by Fernando Grosjean on 4/3/19.
//  Copyright © 2019 Fernando Grosjean. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupIQKeyboardManager()
        window?.rootViewController?.view.tintAdjustmentMode = .normal
        print("hello world Fernando Grosjean")
        
        return true
    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = ""
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
}

