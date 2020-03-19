//
//  ParticipatonEndedVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class ParticipatonEndedVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.commonNavigationBar(title: "", controller: Constant.Controllers.PartionEnded)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func partcptnEndedBtnTppd(_ sender: Any) {
        
        let vc = Constant.Controllers.StudyCode.get() as! StudyCodeVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
