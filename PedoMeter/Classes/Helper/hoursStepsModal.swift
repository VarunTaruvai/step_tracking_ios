//
//  hoursStepsModal.swift
//  PedoMeter
//
//  Created by saurav sinha on 13/03/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class hoursStepsModal: NSObject {
    
    var currntHours = String()
    var nxtHours = String()
    var steps = Int()
    
    init(curntHurs : String, stepsTkn : Int, nxtHur : String) {
        
        self.currntHours = curntHurs
        self.steps = stepsTkn
        self.nxtHours = nxtHur
    
    }
}


class serverStepsModal: NSObject {
    var starttime = Double()
    var endtime = Double()
    var userName = String()
    var steps = Int()
    
    init(strtTime : Double, end : Double, userName : String, step : Int) {
        
        self.starttime = strtTime
        self.endtime = end
        self.userName = Utils.getTheString(key: Constant.usrNme)!
        self.steps = step
    
    }
}


class DayWiseModal: NSObject {
    
    var showingDate = String()
    var startDate = Date()
    var endDate = Date()
    var startDateTimeStamp = Double()
    var endDateTimeStamp = Double()
    var steps = Int()
    
    init(shwngDate : String, strtDate : Date, endDate : Date, strtTimeStamp : Double, endTimeStamp : Double, step : Int) {
        
        self.showingDate = shwngDate
        self.startDate = strtDate
        self.endDate = endDate
        self.steps = step
        self.startDateTimeStamp = strtTimeStamp
        self.endDateTimeStamp = endTimeStamp

    }
}
