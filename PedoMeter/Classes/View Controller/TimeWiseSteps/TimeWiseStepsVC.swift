//
//  TimeWiseStepsVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class TimeWiseStepsVC: UIViewController {

    @IBOutlet weak var timeWiseStepsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeWiseStepsTblView.delegate = self
        timeWiseStepsTblView.dataSource = self
        timeWiseStepsTblView.separatorStyle = .none
        self.navigationItem.hidesBackButton = true
        self.commonNavigationBar(title: "", controller: Constant.Controllers.TimeWiseSteps)
        NotificationCenter.default.addObserver(self, selector: #selector(pushHome), name: NSNotification.Name(rawValue: "pushToNxt"), object: nil)
        // Do any additional setup after loading the view.
    }

    @IBAction func endPartcptonTappd(_ sender: Any) {
        
        let vc = Constant.Controllers.EndPArticpton.get() as! EndParticiptonVC
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func pushHome() {
        
        let vc = Constant.Controllers.PartionEnded.get() as! ParticipatonEndedVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TimeWiseStepsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.timeWiseFrstLblArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeWiseStepsTbleCell", for: indexPath)
        
        let imgView = cell.viewWithTag(1) as! UIImageView
        imgView.image = UIImage(named: Constant.timeWiseImgArr[indexPath.row])
        let frstLbl = cell.viewWithTag(2) as! UILabel
        frstLbl.text = Constant.timeWiseFrstLblArr[indexPath.row]
        let stepsLbl = cell.viewWithTag(3) as! UILabel
        stepsLbl.text = Constant.timeWiseStepsLblArr[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = Constant.Controllers.StepsDetails.get() as! StepsDetailsVC
      //  vc.whichRow = indexPath.row
      //  vc.personNme = Constant.edocsNameArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
