//
//  PlanRepository.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran Gehlen Bornholdt on 29/01/18.
//  Copyright © 2018 squarebits. All rights reserved.
//

import UIKit

class PlanRepository: BaseRequest {

    static func getPlan(completion: @escaping (_ plan: Plan?) -> Void) {
        endPoint = "/plan"
        
        doDefaultRequestWith(requestType: .get, completionOnSingleResult: { (resultJSON) in
            
            if let plan = Plan(JSON: resultJSON) {
                completion(plan)
            }else {
                completion(nil)
            }
            
        }, completionOnListResult: { (resultList) in
            
            
        }) { (success) in
            if !success { completion(nil) }
        }
    }
}
