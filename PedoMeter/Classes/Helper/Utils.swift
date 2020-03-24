//
//  Utils.swift
//  PedoMeter
//
//  Created by saurav sinha on 11/03/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import MBProgressHUD


class Utils: NSObject {

    //MARK:- UserDefaults Functions
    static var progressView:MBProgressHUD?

    
    
    
    static func saveTheString(value : String, key : String)
    {
        let userdefault = UserDefaults.standard
        userdefault.set(value, forKey: key)
        userdefault.synchronize()
    }
    
    static func getTheString(key : String) -> String?
    {
        let userdefault = UserDefaults.standard
        guard let decoded  = userdefault.value(forKey: key) as? String else {return nil}
        return decoded
    }
    
    static func saveTheContent(value : Any, key : String)
    {
        let userdefault = UserDefaults.standard
        userdefault.set(value, forKey: key)
        userdefault.synchronize()
       
    }
    
    static func getTheContent(key : String) -> Any?
    {
        let userdefault = UserDefaults.standard
        guard let decoded  = userdefault.object(forKey: key) else {return nil}
        return decoded
    }
    static func removeTheContent(key : String)
    {
        let userdefault = UserDefaults.standard
        userdefault.removeObject(forKey: key)
        userdefault.synchronize()
    }
    
    //MARK:- MBPROGRESSHUd
           static func startLoading(_ view : UIView)
           {
               progressView = MBProgressHUD.showAdded(to: view, animated: true);
               progressView?.animationType = .zoomIn
               progressView?.areDefaultMotionEffectsEnabled = true
               progressView?.isUserInteractionEnabled = false
               view.isUserInteractionEnabled = true
               
               
           }
           static func startLoadingWithText(_ strText: String, view : UIView)
           {
               progressView = MBProgressHUD.showAdded(to: view, animated: true);
               progressView?.label.text = strText;
               progressView?.isUserInteractionEnabled = false
               
           }
           
           static func changeLoadingWithText(_ strText: String)
           {
               progressView?.label.text = strText;
           }
           
           static func stopLoading()
           {
               if self.progressView != nil
               {
                   self.progressView!.hide(animated: true)
               }
           }
}
