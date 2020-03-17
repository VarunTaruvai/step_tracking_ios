//
//  AppDelegate.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        
        let studyCode = Constant.Controllers.StudyCode.get() as? StudyCodeVC
        let home = Constant.Controllers.Home.get() as? HomeTotalStepsVC
        
        if Utils.getTheContent(key: Constant.usrNme) != nil
        {
            
            let nav = UINavigationController.init(rootViewController: home!)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
            
        else {
            
            let nav = UINavigationController.init(rootViewController: studyCode!)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
            
        }
        return true
    }
}

