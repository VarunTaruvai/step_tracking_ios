//
//  AppDelegate.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let studyCode = Constant.Controllers.StudyCode.get() as? StudyCodeVC {
            
            let nav = UINavigationController.init(rootViewController: studyCode)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
            
        }
        return true
    }
}

