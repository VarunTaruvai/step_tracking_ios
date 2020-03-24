//
//  ReachabilityManager.swift
//  BoilerPlate
//
//  Created by shubham tyagi on 26/11/19.
//  Copyright © 2019 shubham tyagi. All rights reserved.
//

import UIKit
import ReachabilitySwift // 1. Importing the Library

@available(iOS 13.0, *)
class ReachabilityManager: NSObject {
    static  let shared = ReachabilityManager()  // 2. Shared instance
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()
    
    
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            DispatchQueue.main.async {
                AppUtils.AppDelegate().isNetworkAvailable = false

            }
            debugPrint("Network became unreachable")
            break
        case .reachableViaWiFi,.reachableViaWWAN:
            DispatchQueue.main.async {
                AppUtils.AppDelegate().isNetworkAvailable = true

            }
            debugPrint("Network reachable through WiFi")
        }
    }
    
    
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability!.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability!.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
}
