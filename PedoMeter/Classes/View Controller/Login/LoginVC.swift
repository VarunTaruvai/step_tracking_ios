//
//  LoginVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
import SafariServices

class LoginVC: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var usernmeTxtField: UITextField!
    @IBOutlet weak var tickBoxBtn: UIButton!
    @IBOutlet weak var loginNxtBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.commonNavigationBar(title: "", controller: Constant.Controllers.Login)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginNxtTppd(_ sender: Any) {
        
        if usernmeTxtField.text?.trimWhiteSpaces() == "" && tickBoxBtn.isSelected == false {
            
            AppUtils.showToast(message: ToastMsg.alLginFldsMandte)
        }
            
        else if usernmeTxtField.text?.trimWhiteSpaces() == "" {
            
            AppUtils.showToast(message: ToastMsg.blnkUsrNme)
        }
            
        else if tickBoxBtn.isSelected == false {
            
            AppUtils.showToast(message: ToastMsg.blnkTNdC)
        }
            
        else {
            
            Utils.saveTheContent(value: usernmeTxtField.text?.trimWhiteSpaces() as Any, key: Constant.usrNme)
            let vc = Constant.Controllers.Home.get() as! HomeTotalStepsVC
            self.navigationController?.pushViewController(vc, animated: true)
            self.removePreviousViewControllers()
            
        }
    }
    
    @IBAction func tickBoxBtnTppd(_ sender: Any) {
        
        tickBoxBtn.isSelected = !tickBoxBtn.isSelected
        
    }
    
    @IBAction func termsNdCondtonTappd(_ sender: Any) {
        
        let url = URL(string: "http://www.google.com")!
        let controller = SFSafariViewController(url: url)
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
