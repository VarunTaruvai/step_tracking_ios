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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginNxtTppd(_ sender: Any) {
        
        if usernmeTxtField.text?.trimWhiteSpaces() == "" {
            
            AppUtils.showToast(message: ToastMsg.blnkUsrNme)
        }
            
        else {
            
            let vc = Constant.Controllers.TimeWiseSteps.get() as! TimeWiseStepsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func termsNdCondtonTappd(_ sender: Any) {
        
    }
}
