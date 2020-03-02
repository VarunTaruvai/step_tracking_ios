//
//  UIVCExtension.swift
//  PedoMeter
//
//  Created by saurav sinha on 29/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    //MARK:- Tap Gesture (for dismissing modal VC)
    public func tapGesture(forVc place: UIViewController, forView view:UIView ) {
        
        let tap = UITapGestureRecognizer(target: place, action: #selector(tapGestureActn))
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapGestureActn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- HideKeybord onclick Return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Touches Began Func
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

//MARK:- Trimming WhiteSpaces
extension String {
    func trimWhiteSpaces() -> String {
        let whiteSpaceSet = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whiteSpaceSet)
    }
}
