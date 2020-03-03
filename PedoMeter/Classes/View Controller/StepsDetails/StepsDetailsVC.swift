//
//  StepsDetailsVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class StepsDetailsVC: UIViewController {

    @IBOutlet weak var stepsDetailsTblView: UITableView!
    @IBOutlet weak var stepsCountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepsDetailsTblView.delegate = self
        stepsDetailsTblView.dataSource = self
        self.commonNavigationBar(title: "Today", controller: Constant.Controllers.StepsDetails)
        stepsDetailsTblView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
}

extension StepsDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Constant.detailsTimeSlotArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepsDetailsTbleCell", for: indexPath)
        
        let timeSlotLbl = cell.viewWithTag(1) as! UILabel
        timeSlotLbl.text = Constant.detailsTimeSlotArr[indexPath.row]
        let stepsCountLbl = cell.viewWithTag(2) as! UILabel
        stepsCountLbl.text = Constant.detailsStepsCountArr[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
}
