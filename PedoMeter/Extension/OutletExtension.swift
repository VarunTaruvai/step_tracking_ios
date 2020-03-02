//
//  OutletExtension.swift
//  PedoMeter
//
//  Created by saurav sinha on 29/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

//MARK:- Button Properties

extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            
            return layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
