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
        case TimeWiseSteps
        case StepsDetails
        case EndPArticpton
        case PartionEnded
        
        func get() -> UIViewController{
            switch self {
            //SignupFirstEntryVC
            case .StudyCode:
                return Storyboards.main.instantiateViewController(withIdentifier : "StudyCodeVC")
                
            case .Login:
                return Storyboards.main.instantiateViewController(withIdentifier: "LoginVC")
                
            case .TimeWiseSteps:
                return Storyboards.main.instantiateViewController(withIdentifier: "TimeWiseStepsVC")
            case .StepsDetails:
                return Storyboards.main.instantiateViewController(withIdentifier: "StepsDetailsVC")
            case .EndPArticpton:
                return Storyboards.main.instantiateViewController(withIdentifier: "EndParticiptonVC")
            case .PartionEnded:
                return Storyboards.main.instantiateViewController(withIdentifier: "ParticipatonEndedVC")
                
            default:
                print("")
            }
        }
        
    }
    
    static let timeWiseFrstLblArr = ["Today", "Last 24 Hours", "This Week", "This Month"]
    static let timeWiseStepsLblArr = ["80 Steps", "56 Steps", "1092 Steps", "22410 Steps"]
    static let timeWiseImgArr = ["img", "p", "pdf", "word"]
}
