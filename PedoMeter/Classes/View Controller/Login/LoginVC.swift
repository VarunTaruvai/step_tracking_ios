//
//  LoginVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var usernmeTxtField: UITextField!
    @IBOutlet weak var termsNdCondtonBtn: UIButton!
    @IBOutlet weak var loginNxtBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.commonNavigationBar(title: "", controller: Constant.Controllers.Login)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginNxtTppd(_ sender: Any) {
        
        if usernmeTxtField.text?.trimWhiteSpaces() == "" && termsNdCondtonBtn.isSelected == false {
            
            AppUtils.showToast(message: ToastMsg.alLginFldsMandte)
        }
        
        else if usernmeTxtField.text?.trimWhiteSpaces() == "" {
            
            AppUtils.showToast(message: ToastMsg.blnkUsrNme)
        }
            
        else if termsNdCondtonBtn.isSelected == false {
            
            AppUtils.showToast(message: ToastMsg.blnkTNdC)
        }
            
        else {
            
            Utils.saveTheContent(value: usernmeTxtField.text?.trimWhiteSpaces() as Any, key: Constant.usrNme)
            let vc = Constant.Controllers.Home.get() as! HomeTotalStepsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func termsNdCondtonTappd(_ sender: Any) {
        
        termsNdCondtonBtn.isSelected = !termsNdCondtonBtn.isSelected
    }
}
