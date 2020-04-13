//
//  HealthKitSetupAssistant.swift
//  PedoMeter
//
//  Created by saurav sinha on 28/02/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import HealthKit

class HealthKitSetupAssistant {
    
    let healthStore = HKHealthStore()
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        //2. Prepare the data types that will interact with HealthKit
        guard let stepsCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        //3. Prepare a list of types you want HealthKit to read and write
        //       let healthKitTypesToWrite: Set<HKSampleType> = [stepsCount]
        
        let healthKitTypesToRead: Set<HKObjectType> = [stepsCount]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: [], read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
            
            
        }
        
    }
    
    
    //MARK:- Total Steps(Time Wise  Steps)
    func getTotalSteps(startDte:Date, endDate:Date,  _ completion: @escaping (Double) -> Void) {
        
        
        
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            fatalError("*** Unable to get the step count type ***")
        }
        
        var startFinalDate = startDte
        
        if (Utils.getLoginDate() >= startDte)
        {
            startFinalDate = Utils.getLoginDate()
        }
        
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: startFinalDate, end: endDate, options: .strictEndDate)
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
            
            print("he", sum.doubleValue(for: HKUnit.count()) )
        }
        
        healthStore.execute(query)
    }
    
    
    //MARK:- common Func For getting steps hourly
    func getHourlySteps(startDte:Date, endDate:Date, _ completion: @escaping (Array<Any>) -> Void) {
        
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            fatalError("*** Unable to get the step count type ***")
        }
        
        var interval = DateComponents()
        interval.hour = 1
        let calendar = Calendar.current
        
        let settingHur =  calendar.component(.hour, from: startDte)
        let anchorDate = calendar.date(bySettingHour: settingHur, minute: 0, second: 0, of: startDte)
        
        let query = HKStatisticsCollectionQuery.init(quantityType: stepCountType,
                                                     quantitySamplePredicate: nil,
                                                     options: .cumulativeSum,
                                                     anchorDate: anchorDate!,
                                                     intervalComponents: interval)
        
        query.initialResultsHandler = {
            query, results, error in
            
            var arr = [hoursStepsModal]()
            
            results?.enumerateStatistics(from: startDte,
                                         to: endDate, with: { (result, stop) in
                                            
                                            print("Timehai: \(result.startDate), \(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0), \(result.endDate)")
                                            
                                            // current Date
                                            let date = Date()
                                            let dteFrmt = DateFormatter()
                                            dteFrmt.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
                                            dteFrmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            let curntDte = dteFrmt.string(from: date)
                                            dteFrmt.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
                                            let newCurntDte = dteFrmt.date(from: curntDte)!
                                            
                                            // Strt And End Date
                                            let format = DateFormatter()
                                            format.dateFormat = "ha"
                                            format.amSymbol = "am"
                                            format.pmSymbol = "pm"
                                            format.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
                                            let currenthour = format.string(from: result.startDate)
                                            let nexthur = format.string(from: result.endDate)
                                            
                                            if result.endDate > newCurntDte {
                                                
                                                let diff = result.endDate.hours(from: newCurntDte)
                                                
                                                if diff < 1 {
                                                   arr.append(hoursStepsModal(curntHurs: currenthour, stepsTkn: Int(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0), nxtHur: nexthur))
                                                }
                                                print("no")
                                                return
                                                
                                            }
                                            else {
                                                
                                                print("yes")
                                                arr.append(hoursStepsModal(curntHurs: currenthour, stepsTkn: Int(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0), nxtHur: nexthur))
                                            }
                                            
            })
            
            completion(arr)
        }
        healthStore.execute(query)
        
    }
    
    
    
    
    //MARK:- common Func For getting steps hourly
    func getHourlyStepsForServer( _ completion: @escaping ([serverStepsModal]) -> Void) {
        
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            fatalError("*** Unable to get the step count type ***")
        }
        
        var interval = DateComponents()
        interval.hour = 1
        let calendar = Calendar.current
        
        let dte = Date(timeIntervalSince1970: Double(Utils.getTheString(key: Constant.timeStamp)!)!)
         let dteFrmt = DateFormatter()
        dteFrmt.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        dteFrmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dteFrmt.string(from: dte)
         dteFrmt.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        let startDte = dteFrmt.date(from: dateStr)!
        
        let endDate = Date().endOfDay
        
        let settingHur =  calendar.component(.hour, from: startDte)
        let anchorDate = calendar.date(bySettingHour: settingHur, minute: 0, second: 0, of: startDte)
        
        let query = HKStatisticsCollectionQuery.init(quantityType: stepCountType,
                                                     quantitySamplePredicate: nil,
                                                     options: .cumulativeSum,
                                                     anchorDate: anchorDate!,
                                                     intervalComponents: interval)
        
        query.initialResultsHandler = {
            query, results, error in
            
            var arr = [serverStepsModal]()
            
            results?.enumerateStatistics(from: startDte,
                                         to: endDate, with: { (result, stop) in
                                            
                                            print("Timehai: \(result.startDate), \(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0), \(result.endDate)")
                                            
                                            
                                            let startTime = result.startDate.timeIntervalSince1970
                                            let endTime = result.endDate.timeIntervalSince1970
                                            
                                            
 
                                            
                                            if endTime > Date().timeIntervalSince1970 {

                                                print("no")
                                                return

                                            }
                                            else {
                                                
                                                print("yes")
                                                arr.append(serverStepsModal(strtTime: startTime, end: endTime, userName: "", step: Int(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0)))
                                             
                                           }
                                            
            })
            
            completion(arr)
        }
        healthStore.execute(query)
        
    }
    
    
    
    
}

