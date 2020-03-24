//
//  StudyCodeVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class StudyCodeVC: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var studyCodeTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commonNavigationBar(title: "", controller: Constant.Controllers.StudyCode)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
       {
           super.viewDidAppear(true);
           print("view did appear");
           self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
           self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
           self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
           self.navigationController?.interactivePopGestureRecognizer!.delegate = self
           
       }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
       {
           
           if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer)
           {
               if (self.navigationController?.viewControllers.count ?? 0 > 1)
               {
                   return true
               }
               
               return false
           }
           
           return true
       }
    
    
    // MARK: - ServerApiCall
    func checkStudyCodeValidation()
    {
        Utils.startLoading(self.view)
        let param = ["studyCode" : self.studyCodeTxtField.text!]
        Service.sharedInstance.postRequest(Url: Constant.APIs.checkStudyCode , modalName: StudyCodeModel.self, parameter: param as [String : Any]) { (result, error) in
            Utils.stopLoading()
            guard let json = result else {return}
            
            if json.Success! == "1"
            {
                let vc = Constant.Controllers.Login.get() as! LoginVC
                vc.studyCode = self.studyCodeTxtField.text!
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else
            {
                AppUtils.showToast(message: json.Message!)
            }

            
        }
    }
    
    
    // MARK: - UIButtonAction

    @IBAction func studyCodeNxtTppd(_ sender: Any) {
        
        if studyCodeTxtField.text?.trimWhiteSpaces() == "" {
            
            AppUtils.showToast(message: ToastMsg.blnkStudyCode)
        }
        
        else {
            checkStudyCodeValidation()
           
        }
    }
    
}

