//
//  APIModel.swift
//  PedoMeter
//
//  Created by Ankit  Jain on 24/03/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit



struct StudyCodeModel : Codable {
    let Message : String?
    let Success : Int?

    enum CodingKeys: String, CodingKey {
        case Message = "Message"
        case Success = "Success"
    }

}

struct EndStudyModel : Codable {
     let Message : String?
       let Success : Int?

       enum CodingKeys: String, CodingKey {
           case Message = "msg"
           case Success = "status"
       }

}

struct StepSaveModel : Codable {
    let Message : String?
    let Success : Int?

    enum CodingKeys: String, CodingKey {
        case Message = "Message"
        case Success = "Success"
    }

}


struct UserNameModel : Codable {
    let Message : String?
    let Success : Int?

    enum CodingKeys: String, CodingKey {
        case Message = "Message"
        case Success = "Success"
    }

}
