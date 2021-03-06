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
    
    
    static func getMachinesItens(idMachine:String, completion: @escaping (_ itens: [MachineItem]?, _ onSuccess: Bool) -> ()){
        
        endPoint = "/machines/\(idMachine)/items"
        doDefaultRequestWith(requestType: .get, completionOnSingleResult: { (_) in
            
        }, completionOnListResult: { (resultList) in
            
            var machineItens: [MachineItem] = []
            for result in resultList {
                if let json = result as? [String: AnyObject], let item = MachineItem(JSON: json) {
                    machineItens.append(item)
                }
            }
            
            if machineItens.count > 0 {
//                session.machines = machines
                completion(machineItens,true)
            }else {
                completion(nil,false)
            }
            
        }) { (success) in
            if !success { completion(nil,success) }
        }
    }
    
    static func getMachineItem(idMachine:String,idItem:String, completion: @escaping (_ item: MachineItem?, _ onSuccess: Bool) -> ()){
        
        endPoint = "/machines/\(idMachine)/items/\(idItem)"
        doDefaultRequestWith(requestType: .get, completionOnSingleResult: { (json) in
            var machineItem: MachineItem?
            if let item = MachineItem(JSON: json) {
                machineItem = item
                //                session.machines = machines
                completion(machineItem,true)
            }else {
                completion(nil,false)
            }
        }, completionOnListResult: { (resultList) in
            
        }) { (success) in
            if !success { completion(nil,success) }
        }
    }
    
    
    static func postRating(_ rating: Rating, completion: @escaping onSuccess) {
        endPoint = "/rating"
        let params = rating.toJSON() as [String: AnyObject]
        
        doDefaultRequestWith(requestType: .post, parameters: params, completionOnSingleResult: { (resultJson) in
            //any handle here
            
        }, completionOnListResult: { (_) in
            
        }) { (success) in
            completion(success)
        }
    }
}
