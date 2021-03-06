//
//  HoursWiseStepsVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 16/03/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class HoursWiseStepsVC: UIViewController {
    
    @IBOutlet weak var hoursWiseTblView: UITableView!
    @IBOutlet weak var totalStepsCountLbl: UILabel!
    
    var whichTitle = ""
    let healthKit = HealthKitSetupAssistant()
    var dataFrmModal = [hoursStepsModal]()
    var dayModal : DayWiseModal?
    var totlStepsCountOfDte = Int()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hoursWiseTblView.delegate = self
        hoursWiseTblView.dataSource = self
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(pushToHourlyStats), for: .valueChanged)
        hoursWiseTblView.addSubview(refreshControl)
        self.totalStepsCountLbl.text = String(describing: dayModal!.steps)
        self.commonNavigationBar(title: dayModal!.showingDate, controller: Constant.Controllers.DaysDetails)
        hoursWiseTblView.separatorStyle = .none
        
         NotificationCenter.default.addObserver(self, selector: #selector(pushToHourlyStats), name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.hourRefreshNoti), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.pushToHourlyStats()
    }
    
}

extension HoursWiseStepsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataFrmModal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepsDetailsTbleCell", for: indexPath)
        let timeImgView = cell.viewWithTag(1) as! UIImageView
        let timeSlotLbl = cell.viewWithTag(2) as! UILabel
        let stepsCountLbl = cell.viewWithTag(3) as! UILabel
        timeImgView.image = UIImage(named: "hour")
        timeSlotLbl.text = "\(dataFrmModal[indexPath.row].currntHours)-\(dataFrmModal[indexPath.row].nxtHours)"
        stepsCountLbl.text = String(describing: dataFrmModal[indexPath.row].steps)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
}

extension HoursWiseStepsVC {
    
    @objc func pushToHourlyStats () {
        
        self.whichTitle = dayModal!.showingDate
        
        self.healthKit.getTotalSteps(startDte: dayModal!.startDate, endDate: dayModal!.endDate) { (steps) in
            
            self.totlStepsCountOfDte = Int(steps)
            DispatchQueue.main.async {
                
                self.totalStepsCountLbl.text = String(describing: self.totlStepsCountOfDte)
            }
            
        }
        
        self.healthKit.getHourlySteps(startDte: dayModal!.startDate, endDate: dayModal!.endDate) { (array) in
            
            self.dataFrmModal = array as! [hoursStepsModal]
            DispatchQueue.main.async {
                
                self.hoursWiseTblView.reloadData()
                
            }
            
        }
        
        refreshControl.endRefreshing()
    }
    
}

