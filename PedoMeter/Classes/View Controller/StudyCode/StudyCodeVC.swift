//
//  StudyCodeVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class StudyCodeVC: UIViewController {

    @IBOutlet weak var studyCodeTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commonNavigationBar(title: "", controller: Constant.Controllers.StudyCode)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func studyCodeNxtTppd(_ sender: Any) {
        
        if studyCodeTxtField.text?.trimWhiteSpaces() == "" {
            
            AppUtils.showToast(message: ToastMsg.blnkStudyCode)
        }
        
        else {
            let vc = Constant.Controllers.Login.get() as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
