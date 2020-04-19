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
    let healthKit = HealthKitSetupAssistant()
    var isServerCalled : Bool = false


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
        
        
       //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.homeRefreshNoti), object: nil, userInfo: nil)
        self.stepCollectionWork()
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
    
    
    
    func stepCollectionWork()
    {
        healthKit.authorizeHealthKit { (authorized, error) in
    if authorized == false
    { return  }
            
        //MARK:- ServerSideWork
        self.healthKit.getHourlyStepsForServer { (array) in
            
            var reqArr = [[String : Any]]()
            for item in array
            {
           reqArr.append(["starttime":item.starttime,"endtime":item.endtime,"userName":item.userName,"steps":item.steps])
            }
            
            print(reqArr)
            DispatchQueue.main.async {
                if reqArr.count > 0
                {
                    if self.isServerCalled == true {
                            return
                        }
               self.sendDataToServer(param: reqArr)
                    self.isServerCalled = true

                }
            }
            
        }
        
        }
    }
    
    func sendDataToServer(param : [[String:Any]])
    {
    
        Service.sharedInstance.postRequestForHome(Url: Constant.APIs.saveUserSteps , modalName: StepSaveModel.self, parameter: param) { (result, error) in
                  self.isServerCalled  = false
                   Utils.stopLoading()
                   guard let json = result else {return}
                   
                   if json.Success! == 1
                   {
                    let timeStamp = param.last!["endtime"]!
                     Utils.saveTheString(value: "\(timeStamp)", key: Constant.timeStamp)
                   }else
                   {
                   }

                   
               }
    }
    
}

