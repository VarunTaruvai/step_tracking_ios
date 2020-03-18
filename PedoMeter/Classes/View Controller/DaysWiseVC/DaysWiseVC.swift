//
//  StepsDetailsVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class DaysWiseVC: UIViewController {

    let healthKit = HealthKitSetupAssistant()
    var whichRow = 0
    var whichTitle = ""
    var days = [DayWiseModal]()
   // var weekDys = [String]()
    var totlStepsCount = 0
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var daysDetailsTblView: UITableView!
    @IBOutlet weak var stepsCountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysDetailsTblView.delegate = self
        daysDetailsTblView.dataSource = self
        self.commonNavigationBar(title: whichTitle, controller: Constant.Controllers.DaysDetails)
        daysDetailsTblView.separatorStyle = .none
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data", attributes: attributes)
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(pushToDaysStats), for:.valueChanged)
        daysDetailsTblView.addSubview(refreshControl)
        self.stepsCountLbl.text = String(describing: totlStepsCount)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.pushToDaysStats()
    }
    
}


extension DaysWiseVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return days.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepsDetailsTbleCell", for: indexPath)
        let timeSlotLbl = cell.viewWithTag(1) as! UILabel
        let imgView = cell.viewWithTag(2) as! UIImageView
        let modal = days[indexPath.row]
        timeSlotLbl.text = modal.showingDate
        
        if whichRow == 2 {
            
            imgView.image = UIImage(named: "week")
            self.stepsCountLbl.text = String(describing: totlStepsCount)
        }
        
        else {
            
            imgView.image = UIImage(named: "month")
            self.stepsCountLbl.text = String(describing: totlStepsCount)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = Constant.Controllers.HoursWiseSteps.get() as! HoursWiseStepsVC
        vc.dayModal = days[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension DaysWiseVC {
    
    @objc func pushToDaysStats () {
        
        if whichRow == 2 {
            
            self.days = Date.getDaysOfWeek()
            self.daysDetailsTblView.reloadData()
        }
            
        else {
            
            let dateInWeek = Date()
            let format = DateFormatter()
            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = format.string(from: dateInWeek)
            format.timeZone = TimeZone(identifier: "UTC")!
            let todyDte = format.date(from: formattedDate)!
            
            self.days = Date.dates(from: Date().startOfMonth(), to: todyDte)
            self.daysDetailsTblView.reloadData()
        }
        
        refreshControl.endRefreshing()
        
    }
    
}

