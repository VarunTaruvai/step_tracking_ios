//
//  TimeWiseStepsVC.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class HomeTotalStepsVC: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var homeStepsTblView: UITableView!
    let healthKit = HealthKitSetupAssistant()
    var shownWarning : Bool = false
    var todyStepsCount = Int()
    var lst24StepsCount = Int()
    var weeklyStepsCount = Int()
    var mnthlyStepsCount = Int()
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var dateLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateLbl.text = "You are participating in this study since " + Utils.getLoginDateForHome()
   
        homeStepsTblView.delegate = self
        homeStepsTblView.dataSource = self
        self.homeStepsTblView.estimatedRowHeight = 85
        homeStepsTblView.separatorStyle = .none
        self.navigationItem.hidesBackButton = true
        //refresh control
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(totlStepsData), for: .valueChanged)
        homeStepsTblView.addSubview(refreshControl)
        self.commonNavigationBar(title: "Hi \(self.userName),", controller: Constant.Controllers.Home)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushHome), name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.nextNoti), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(totlStepsData), name: NSNotification.Name(rawValue: Constant.NotificationIdentifier.homeRefreshNoti), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.totlStepsData()
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
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true);
        print("view did appear");
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer!.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
    }
    
    @IBAction func endPartcptonTappd(_ sender: Any) {
        
        let vc = Constant.Controllers.EndPArticpton.get() as! EndParticiptonVC
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
    }
    
    // MARK: - ServerApiCall
    func endParticiPationApi()
    {
        Utils.startLoading(self.view)
        let param = ["userName"  : Utils.getTheString(key: Constant.usrNme)!]
        Service.sharedInstance.postRequest(Url: Constant.APIs.endStudyApi , modalName: EndStudyModel.self, parameter: param as [String : Any]) { (result, error) in
            Utils.stopLoading()
            guard let json = result else {return}
            
            if json.Success! == 1
            {
                Utils.removeTheContent(key: Constant.usrNme)
                Utils.removeTheContent(key: Constant.timeStamp)
                Utils.removeTheContent(key: Constant.loginTimeStamp)
                let vc = Constant.Controllers.PartionEnded.get() as! ParticipatonEndedVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else
            {
                AppUtils.showToast(message: json.Message!)
            }

            
        }
    }
    
    
    
    @objc func pushHome() {
        endParticiPationApi()
       
    }
}


//MARK:- Table Properties
extension HomeTotalStepsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.homeStepsLblArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeWiseStepsTbleCell", for: indexPath)
        
        let imgView = cell.viewWithTag(1) as! UIImageView
        imgView.image = UIImage(named: Constant.homeImgArr[indexPath.row])
        
        let frstLbl = cell.viewWithTag(2) as! UILabel
        frstLbl.text = Constant.homeFrstLblArr[indexPath.row]
        
        let stepsLbl = cell.viewWithTag(3) as! UILabel
        
        if indexPath.row == 0 {
            
            stepsLbl.text = "\(String(describing: todyStepsCount)) Steps"
        }
        else if indexPath.row == 1 {
            
            stepsLbl.text = "\(String(describing: lst24StepsCount)) Steps"
        }
        else if indexPath.row == 2 {
            
            stepsLbl.text = "\(String(describing: weeklyStepsCount)) Steps"
        }
        else {
            
            stepsLbl.text = "\(String(describing: mnthlyStepsCount)) Steps"
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.homeStepsTblView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let vc = Constant.Controllers.HoursWiseSteps.get() as! HoursWiseStepsVC
            let modal = DayWiseModal(shwngDate : "Today", strtDate : Date().startOfDay, endDate : Date().endOfDay, strtTimeStamp : Date().startOfDay.timeIntervalSince1970, endTimeStamp : Date().timeIntervalSince1970, step : todyStepsCount)
            
            vc.dayModal = modal
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
        else if indexPath.row == 1 {
            
            let vc = Constant.Controllers.HoursWiseSteps.get() as! HoursWiseStepsVC
            
            //Last 24 hours Start Date
            let date1 = Date().addingTimeInterval(-3600 * 24)
            let format1 = DateFormatter()
            format1.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            format1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate1 = format1.string(from: date1)
            format1.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            var last24Strt = format1.date(from: formattedDate1)!
            
            if Utils.getLoginDate() >= last24Strt {
                                     last24Strt = Utils.getLoginDate()
                                 }
            
            
            
            let modal = DayWiseModal(shwngDate : "Last 24 Hours", strtDate : last24Strt, endDate : Date().endOfDay, strtTimeStamp : Date().startOfDay.timeIntervalSince1970, endTimeStamp : Date().timeIntervalSince1970, step : lst24StepsCount)
            
            vc.dayModal = modal
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
        else {
            
            let vc = Constant.Controllers.DaysDetails.get() as! DaysWiseVC
            vc.whichRow = indexPath.row
            vc.whichTitle = Constant.homeFrstLblArr[indexPath.row]
            
            if indexPath.row == 2 {
                
                vc.totlStepsCount = self.weeklyStepsCount
            }
            else {
                
                vc.totlStepsCount = self.mnthlyStepsCount
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK:- Disallow Alert
extension HomeTotalStepsVC {
    
    func notAllowAlert() {
        let name = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

        let alert = UIAlertController(title: "No Steps Data Found", message: "There was no steps data found for you. If you expected to see data, it may be that \(name) is not authorised to read your steps count. Please go to the settings app (Privacy -> Health -> \(name)) to change this.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler:  { action in
            if let url = URL(string:UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }            }))
        alert.view.tintColor = UIColor(red: 204.0/255.0, green: 0.0, blue: 51.0/255.0, alpha: 1.0)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func totlStepsData() {
        
        healthKit.authorizeHealthKit { (authorized, error) in
            
//            guard authorized else {
//
//                let baseMessage = "HealthKit Authorization Failed"
//                if let error = error {
//                    print("\(baseMessage). Reason: \(error.localizedDescription)")
//                }
//                else {
//                    print(baseMessage)
//                }
//
//                return
//            }
            
            if authorized == false
            {
                DispatchQueue.main.async {
                    self.dateLbl.text = "Your step data is not being measured"
                    self.notAllowAlert()
                }
                return
            }else
            {
               DispatchQueue.main.async {
                    self.dateLbl.text = "You are participating in this study since " + Utils.getLoginDateForHome()
                }
            }
            
            //Current Date And Time
            let date = Date()
            let format = DateFormatter()
            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = format.string(from: date)
            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            let todyEndDte = format.date(from: formattedDate)!
            
            //MARK:- Today
            self.healthKit.getTotalSteps(startDte: Date().startOfDay, endDate: todyEndDte) { (steps) in
                
//                if steps == 0.0 && self.shownWarning == false {
//                    self.shownWarning = true
//                    DispatchQueue.main.async {
//                        self.notAllowAlert()
//                    }
//
//                }
//
//                else {
                    self.todyStepsCount = Int(steps)
                    DispatchQueue.main.async {
                        self.homeStepsTblView.reloadData()
                    }
                    
//                }
            }
            
            //MARK:- Last 24 Hours
            let date1 = Date().addingTimeInterval(-3600 * 24)
            let format1 = DateFormatter()
            format1.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            format1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate1 = format1.string(from: date1)
            format1.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            let last24Strt = format1.date(from: formattedDate1)!
            
            self.healthKit.getTotalSteps(startDte: last24Strt, endDate: todyEndDte) { (steps) in
                
                self.lst24StepsCount = Int(steps)
                DispatchQueue.main.async {
                    self.homeStepsTblView.reloadData()
                }
                
            }
            
            //MARK:- This Week
            self.healthKit.getTotalSteps(startDte: Date().startOfWeek(), endDate: todyEndDte) { (steps) in
                
                self.weeklyStepsCount = Int(steps)
                DispatchQueue.main.async {
                    self.homeStepsTblView.reloadData()
                }
            }
            
            //MARK:- This Month
            self.healthKit.getTotalSteps(startDte: Date().startOfMonth(), endDate: todyEndDte) { (steps) in
                
                //                if steps == 0.0 && self.shownWarning == false {
                //                    self.shownWarning = true
                //                    DispatchQueue.main.async {
                //                        self.notAllowAlert()
                //                    }
                //
                //                }
                //                else {
                self.mnthlyStepsCount = Int(steps)
                DispatchQueue.main.async {
                    self.homeStepsTblView.reloadData()
                    //           }
                }
     
            }
            
            
            //MARK:- ServerSideWork
            DispatchQueue.main.async {

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.stepCollectionWork()
            }
            print("HealthKit Successfully Authorized.")
        }
        refreshControl.endRefreshing()
        
    }
    
    
    

}
