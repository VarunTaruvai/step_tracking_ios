//
//  UIVCExtension.swift
//  PedoMeter
//
//  Created by saurav sinha on 29/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    
    func commonNavigationBar(title:String , controller:Constant.Controllers)
        
    {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SF UI Display", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.hidesBackButton = true
        
        switch (controller) {
        case .DaysDetails :
            
            let button = UIButton(type: .custom)
            button.setImage(UIImage (named: "back_btn"), for: .normal)
            button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
            let leftButton = UIBarButtonItem(customView: button)
            //            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            //            button.widthAnchor.constraint(equalToConstant: 15).isActive = true
            self.navigationItem.leftBarButtonItem = leftButton
            
        default : break
            
        }
    }
    
    @objc fileprivate func backButton() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //remove previous view controllers
    func removePreviousViewControllers()
    {
        if var array = self.navigationController?.viewControllers
        {
            
            let index = array.firstIndex(of: self)!
            
            for i in (0...index).reversed() where i < array.count {
                array.remove(at: i)
            }
            self.navigationController?.viewControllers = array
        }
    }
    
    //MARK:- Tap Gesture (for dismissing modal VC)
    public func tapGesture(forVc place: UIViewController, forView view:UIView ) {
        
        let tap = UITapGestureRecognizer(target: place, action: #selector(tapGestureActn))
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapGestureActn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- HideKeybord onclick Return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Touches Began Func
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    var userName : String
    {
        guard let name = Utils.getTheString(key: Constant.usrNme) else {
            return ""
        }
        return name
    }
    
    
}

//MARK:- Trimming WhiteSpaces
extension String {
    func trimWhiteSpaces() -> String {
        let whiteSpaceSet = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whiteSpaceSet)
    }
}

//MARK:- Date Extensions
extension Date {
    
    //Start Of Month
    func startOfMonth() -> Date {
        
        var calender = Calendar.current
        calender.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        return calender.date(from: calender.dateComponents([.year, .month], from: calender.startOfDay(for: self)))!
    }
    
    
    //end Of Month
    func endOfMonth() -> Date {
        
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    
    //Start Of Week
    func startOfWeek() -> Date {
        
        var calender = Calendar.current
        calender.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        let sunday = calender.date(from: calender.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        
        return calender.date(byAdding: .day, value: 1, to: sunday)!
    }
    
    //Days Of Month
    static func dates(from fromDate: Date, to toDate: Date) -> [DayWiseModal] {
        var dates: [Date] = []
        var date = fromDate
        
        let format = DateFormatter()
        format.dateFormat = "d MMM yyyy"
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        
        var array = [DayWiseModal]()
        
        for item in dates
        {
            let strtTimeStamp = item.startOfDay.timeIntervalSince1970
            let endTimeStamp = item.endOfDay.timeIntervalSince1970
            let finalEnd = endTimeStamp > Date().timeIntervalSince1970 ? Date().timeIntervalSince1970 : endTimeStamp
            //vurrent date and time
            let date = Date()
            let format = DateFormatter()
            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = format.string(from: date)
            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            let todyEndDte = format.date(from: formattedDate)!
            
            let finalEndDate = endTimeStamp > Date().timeIntervalSince1970 ? todyEndDte : item.endOfDay
            
            let newformat = DateFormatter()
            newformat.dateFormat = "d MMM yyyy"
            let shwngDate =  newformat.string(from: item)
            let modal = DayWiseModal(shwngDate: shwngDate, strtDate: item.startOfDay, endDate: finalEndDate, strtTimeStamp: strtTimeStamp, endTimeStamp: finalEnd, step: 0)
            array.append(modal)
        }
        
        return array
    }
    
    //Days Of Week
    static func getDaysOfWeek() -> [DayWiseModal] {
        
        let dateInWeek = Date()
        let format = DateFormatter()
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        format.dateFormat = "E, d MMM yyyy"
        let formattedDate = format.string(from: dateInWeek)
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        let todyEndDte = format.date(from: formattedDate)!
        
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: todyEndDte) - 1
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: todyEndDte)!
        let days = (weekdays.lowerBound ..< dayOfWeek+1)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: todyEndDte) }
        
        var array = [DayWiseModal]()
        for item in days
        {
            let strtTimeStamp = item.startOfDay.timeIntervalSince1970
            let endTimeStamp = item.endOfDay.timeIntervalSince1970
            
            let finalEnd = endTimeStamp > Date().timeIntervalSince1970 ? Date().timeIntervalSince1970 : endTimeStamp
            
            //current date and time
            let date = Date()
            let format = DateFormatter()
            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = format.string(from: date)
            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
            let todyEndDte = format.date(from: formattedDate)!
            
            let finalEndDate = endTimeStamp > Date().timeIntervalSince1970 ? todyEndDte : item.endOfDay

            let newformat = DateFormatter()
            newformat.dateFormat = "E, d MMM yyyy"
            let shwngDate =  newformat.string(from: item)
            let modal = DayWiseModal(shwngDate: shwngDate, strtDate: item.startOfDay, endDate: finalEndDate, strtTimeStamp: strtTimeStamp, endTimeStamp: finalEnd, step: 0)
            array.append(modal)
        }
        
        
        return array
    }
    
    // Start of day
    var startOfDay: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        return calendar.startOfDay(for: self)
    }
    
    // End of day
    var endOfDay: Date {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfDay)!
    }
    
}
