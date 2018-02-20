//
//  ClickRepository.swift
//  ClickServicesApp
//
//  Created by Luan Silva Gehlen Bornholdt on 15/01/18.
//  Copyright © 2018 squarebits. All rights reserved.
//

import UIKit

class MachineRepository: BaseRequest {

    static func getMachines(completion: @escaping onSuccess) {
        
        endPoint = "/locations"
        doDefaultRequestWith(requestType: .get, completionOnSingleResult: { (_) in
            
        }, completionOnListResult: { (resultList) in
            
            var machines: [Machine] = []
            for result in resultList {
                if let json = result as? [String: AnyObject], let machine = Machine(JSON: json) {
                    machines.append(machine)
                }
            }
            
            if machines.count > 0 {
                session.machines = machines
                completion(true)
            }else {
                completion(false)
            }
            
        }) { (success) in
            if !success { completion(success) }
        }
    }
    
}
