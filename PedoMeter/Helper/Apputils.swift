//
//  Apputils.swift
//  PedoMeter
//
//  Created by saurav sinha on 29/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import Toaster

class AppUtils: NSObject {
    
    //MARK: appdelegate object
    static func AppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK:- SkipTwoVC(back)
    static func goToPreviousPage(navigation:UINavigationController?,whichPage:AnyObject)
    {
        if let nav = navigation
        {
            let navigationArray = nav.viewControllers
            for (index,item) in (navigationArray.enumerated())
            {
                if item.isKind(of: whichPage as! AnyClass)
                {
                    navigation?.popToViewController((navigation?.viewControllers[index])!, animated: true)
                }
            }
        }
    }
    
    //Toast
    static func showToast(message : String)
    {
        
        let toast = Toast(text: message, delay: 0.1, duration: 1.5)
        toast.view.backgroundColor = UIColor.darkGray
        toast.view.font = UIFont.systemFont(ofSize: 14)
        toast.show()
        
    }
    
}

