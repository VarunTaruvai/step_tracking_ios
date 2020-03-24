//
//  Service.swift
//  BoilerPlate
//
//  Created by shubham tyagi on 24/11/19.
//  Copyright © 2019 shubham tyagi. All rights reserved.
//

import UIKit

class Service: NSObject {
    static let sharedInstance = Service()
    
    //MARK:- Get API
    func getRequest<T:Decodable>(Url:String, modalName:T.Type,completion:@escaping ((T?,Error?) -> Void))
    {
      if AppUtils.AppDelegate().isNetworkAvailable == false
               {
                   Utils.stopLoading()
                   AppUtils.showToast(message: Constant.ErrorMsg.offLineMsg)
                   return
               }
        guard let url = URL(string: (Url)) else {return}
        
        URLSession.shared.dataTask(with: url){(data,response,error) in
            DispatchQueue.main.async
            {
            if let err = error{
                AppUtils.showToast(message: Constant.ErrorMsg.errorMsg);
                print("error-:\(err.localizedDescription)")
                completion(nil,err )

            }
            guard let data = data
                else{
                    AppUtils.showToast(message: Constant.ErrorMsg.errorMsg);
                    completion(nil,nil)
                   print("data is nil")
                return}
            
            do{
            
                Log.printConsole(output:  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any], msg: "Shows Data")
                
                let json = try JSONDecoder().decode(modalName.self, from: data)
                
                
                completion(json,nil)
            }catch let jsonerr{
                AppUtils.showToast(message: "error-:\(jsonerr.localizedDescription)");
                print("error-:\(jsonerr.localizedDescription)")
                completion(nil,jsonerr)
            }
            }
        }.resume()
    }
    
    //MARK:- POST API
    
    func postRequest<T:Decodable>(Url:String,modalName:T.Type,parameter:[String:Any],completion:@escaping ((T?,Error?) -> Void))
    {
        
       if AppUtils.AppDelegate().isNetworkAvailable == false
        {
            Utils.stopLoading()
            AppUtils.showToast(message: Constant.ErrorMsg.offLineMsg)
            return
        }
        guard let url = URL(string: (Url)) else {return}
        print(Url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else{return}
        
        request.httpBody = httpBody
        print(parameter)
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async
            {
            if let err = error{
                AppUtils.showToast(message: Constant.ErrorMsg.errorMsg);
                print("error-:\(err.localizedDescription)")
                completion(nil,err )

            }
            
            guard let data = data else{return}
            do{
                  
                      Log.printConsole(output:  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any], msg: "Response")
                      
                      let json = try JSONDecoder().decode(modalName.self, from: data)
                      
                      
                      completion(json,nil)
                  }catch let jsonerr{
                      AppUtils.showToast(message: "error-:\(jsonerr.localizedDescription)");
                      print("error-:\(jsonerr.localizedDescription)")
                      completion(nil,jsonerr)
                  }
            }
        }.resume()
    }
    
    
    //MARK:- POST API
    
         func postRequestForHome<T:Decodable>(Url:String, modalName:T.Type,parameter:[[String:Any]],completion:@escaping ((T?,Error?) -> Void))
    {
        
       if AppUtils.AppDelegate().isNetworkAvailable == false
        {
            Utils.stopLoading()
            AppUtils.showToast(message: Constant.ErrorMsg.offLineMsg)
            return
        }
        guard let url = URL(string: (Url)) else {return}
        print(Url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else{return}
        
        request.httpBody = httpBody
        print(parameter)
         URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async
            {
            if let err = error{
                AppUtils.showToast(message: Constant.ErrorMsg.errorMsg);
                print("error-:\(err.localizedDescription)")
                completion(nil,err )

            }
            
            guard let data = data else{return}
            do{
                  
                      Log.printConsole(output:  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any], msg: "Response")
                      
                      let json = try JSONDecoder().decode(modalName.self, from: data)
                      
                      
                      completion(json,nil)
                  }catch let jsonerr{
                      AppUtils.showToast(message: "error-:\(jsonerr.localizedDescription)");
                      print("error-:\(jsonerr.localizedDescription)")
                      completion(nil,jsonerr)
                  }
            }
        }.resume()
    }
    
}



class Log {

  static func printConsole(output: Any, msg: String) {
    if Constant.Testing == 1{
      print("\(msg): \(output)")
    }
  }
}


