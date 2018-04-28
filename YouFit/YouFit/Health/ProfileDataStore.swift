//
//  ProfileDataStore.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/27/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import Foundation
import HealthKit

class ProfileDataStore {
    
    class func getAgeSexAndBloodType() throws -> (age: Int,
        biologicalSex: HKBiologicalSex,
        bloodType: HKBloodType) {
            
            let healthKitStore = HKHealthStore()
            
            do {
                let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
                let biologicalSex =       try healthKitStore.biologicalSex()
                let bloodType =           try healthKitStore.bloodType()
                
           
                let today = Date()
                let calendar = Calendar.current
                let todayDateComponents = calendar.dateComponents([.year],
                                                                  from: today)
                let thisYear = todayDateComponents.year!
                let age = thisYear - birthdayComponents.year!
                
                print("age")
                print(age)
                
              
                let unwrappedBiologicalSex = biologicalSex.biologicalSex
                let unwrappedBloodType = bloodType.bloodType
                
                return (age, unwrappedBiologicalSex, unwrappedBloodType)
            }
    }
    
    class func getMostRecentSample(for sampleType: HKSampleType,
                                   completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                                            
                                            
                                            DispatchQueue.main.async {
                                                
                                                guard let samples = samples,
                                                    let mostRecentSample = samples.first as? HKQuantitySample else {
                                                        
                                                        completion(nil, error)
                                                        return
                                                }
                                                
                                                completion(mostRecentSample, nil)
                                            }
        }
        
        HKHealthStore().execute(sampleQuery)
    }
    
    class func saveBodyMassIndexSample(bodyMassIndex: Double, date: Date) {
        
        //1.  Make sure the body mass type exists
        guard let bodyMassIndexType = HKQuantityType.quantityType(forIdentifier: .bodyMassIndex) else {
            fatalError("Body Mass Index Type is no longer available in HealthKit")
        }
        
        //2.  Use the Count HKUnit to create a body mass quantity
        let bodyMassQuantity = HKQuantity(unit: HKUnit.count(),
                                          doubleValue: bodyMassIndex)
        
        let bodyMassIndexSample = HKQuantitySample(type: bodyMassIndexType,
                                                   quantity: bodyMassQuantity,
                                                   start: date,
                                                   end: date)
        
        //3.  Save the same to HealthKit
        HKHealthStore().save(bodyMassIndexSample) { (success, error) in
            
            if let error = error {
                print("Error Saving BMI Sample: \(error.localizedDescription)")
            } else {
                print("Successfully saved BMI Sample")
            }
        }
    }
}
