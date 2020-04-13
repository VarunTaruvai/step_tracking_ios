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
    
    var isNetworkAvailable:Bool?

    var window: UIWindow?
    var visibleViewController: UIViewController? {
           var currentVc = UIApplication.shared.keyWindow?.rootViewController
           while let presentedVc = currentVc?.presentedViewController {
               if let navVc = (presentedVc as? UINavigationController)?.viewControllers.last {
                   currentVc = navVc
               } else if let tabVc = (presentedVc as? UITabBarController)?.selectedViewController {
                   currentVc = tabVc
               } else {
                   currentVc = presentedVc
               }
           }
           if let vc = (currentVc as? UINavigationController)?.viewControllers.last
           {
               return vc
           }

           return currentVc
       }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        
        
        application.setMinimumBackgroundFetchInterval(21600)

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
        //registerBackgroundTaks()
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if application.backgroundRefreshStatus == .available {
            // yay!
            print("background available")

        }else{
            print("background denied")

        }
        print("background refresh")
        
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.homeRefreshNoti), object: nil, userInfo: nil)
        completionHandler(UIBackgroundFetchResult.newData)

        
    }
    
   
//    private func registerBackgroundTaks() {
//    BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.sanganan.appfetch", using: nil) { task in
//    //This task is cast with processing request (BGProcessingTask)
//    self.scheduleLocalNotification()
//    self.handleImageFetcherTask(task: task as! BGProcessingTask)
//    }
//    BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.sanganan.apprefresh", using: nil) { task in
//    //This task is cast with processing request (BGAppRefreshTask)
//    self.scheduleLocalNotification()
//    self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
//    }
//    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
           print("visible view con in foreground",self.visibleViewController)
        if self.visibleViewController is HomeTotalStepsVC {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.homeRefreshNoti), object: nil, userInfo: nil)
        }else if self.visibleViewController is DaysWiseVC
        {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.dayRefreshNoti), object: nil, userInfo: nil)
        }else if self.visibleViewController is HoursWiseStepsVC
        {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.hourRefreshNoti), object: nil, userInfo: nil)
        }
        

       }
       func applicationWillResignActive(_ application: UIApplication) {
           print("visible view con",self.visibleViewController)
       }
    
}

