//
//  UIVCExtension.swift
//  PedoMeter
//
//  Created by saurav sinha on 29/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    
    func commonNavigationBar(title:String , controller:Constant.Controllers)
        
    {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SF UI Display", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.hidesBackButton = true
        
        switch (controller) {
        case .StepsDetails :
            
            let button = UIButton(type: .custom)
            button.setImage(UIImage (named: "back_btn"), for: .normal)
            button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
            let leftButton = UIBarButtonItem(customView: button)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 15).isActive = true
            self.navigationItem.leftBarButtonItem = leftButton
            
        default : break
            
        }
    }
    
    @objc fileprivate func backButton() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
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
