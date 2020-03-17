//
//  Constant.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    public  struct Storyboards {
        
        static let main = UIStoryboard(name:"Main",bundle:nil)
    }
    
    public enum Controllers{
        case StudyCode
        case Login
        case Home
        case DaysDetails
        case HoursWiseSteps
        case EndPArticpton
        case PartionEnded
        
        func get() -> UIViewController{
            switch self {
            //SignupFirstEntryVC
            case .StudyCode:
                return Storyboards.main.instantiateViewController(withIdentifier : "StudyCodeVC")
            case .Login:
                return Storyboards.main.instantiateViewController(withIdentifier: "LoginVC")
            case .Home:
                return Storyboards.main.instantiateViewController(withIdentifier: "HomeTotalStepsVC")
            case .DaysDetails:
                return Storyboards.main.instantiateViewController(withIdentifier: "DaysWiseVC")
            case .HoursWiseSteps:
                return Storyboards.main.instantiateViewController(withIdentifier: "HoursWiseStepsVC")
            case .EndPArticpton:
                return Storyboards.main.instantiateViewController(withIdentifier: "EndParticiptonVC")
            case .PartionEnded:
                return Storyboards.main.instantiateViewController(withIdentifier: "ParticipatonEndedVC")
                
            default:
                print("")
            }
        }
        
    }
    
    
    // TimeWiseSteps VC
    static let homeFrstLblArr = ["Today", "Last 24 Hours", "This Week", "This Month"]
    static let homeStepsLblArr = ["80 Steps", "56 Steps", "1092 Steps", "22410 Steps"]
    static let homeImgArr = ["step", "hour", "week", "month"]
    
    //StepsDetails VC
    static let detailsTimeSlotArr = ["8am-9am", "9am-10am", "10am-11am", "12pm-1pm", "1pm-2pm", "3pm-4pm", "5pm-6pm"]
    static let detailsStepsCountArr = ["992 Steps", "82 Steps", "92 Steps", "92 Steps", "20 Steps", "62 Steps", "62 Steps"]
    
    //UserDefaults Data
    static let usrNme = "usrNme"
    
}
