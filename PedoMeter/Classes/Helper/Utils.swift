//
//  Utils.swift
//  PedoMeter
//
//  Created by saurav sinha on 11/03/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class Utils: NSObject {

    //MARK:- UserDefaults Functions
    
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
}
