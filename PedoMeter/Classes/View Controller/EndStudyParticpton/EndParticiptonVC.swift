//
//  EndParticiptonVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class EndParticiptonVC: UIViewController {

    @IBOutlet weak var secondView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tapGesture(forVc: self, forView: self.secondView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func canclBtnTappd(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesBtnTppd(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            let userdefault = UserDefaults.standard
            userdefault.removeObject(forKey: Constant.usrNme)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushToNxt"), object: nil, userInfo: nil)
        }
    }
    @IBAction func noBtnTppd(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
