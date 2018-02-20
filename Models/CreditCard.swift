//
//  CreditCard.swift
//  ClickServicesApp
//
//  Created by Luan Silva Gehlen Bornholdt on 29/01/18.
//  Copyright © 2018 squarebits. All rights reserved.
//

import UIKit

class CreditCard: NSObject {
    
    var cardNumber = ""
    var cardValidThrough = ""
    var cardCVV = ""
    var cardHolder = ""
    var plan: Plan
    
    required init(plan: Plan) {
        self.plan = plan
        super.init()
    }

    func getParams() -> [String: AnyObject]? {
        
        //Name
        var firstName = ""
        var lastName = ""
        let nameArray = cardHolder.split(separator: " ")
        
        if nameArray.count > 2 {
            firstName = nameArray[0] + " " + nameArray[1]
            lastName = nameArray[3]
        }else {
            firstName = nameArray[0]
            lastName = nameArray[1]
        }
        
        //Card Valid Through
        let dateArray = cardValidThrough.split(separator: "/")
        
        guard let month = Int(dateArray[0]) else {
            return nil
        }
        guard let year = Int(dateArray[1]) else {
            return nil
        }
        
        let data: [String: Any] = ["number": cardNumber,
                                   "verification_value": cardCVV,
                                   "first_name": firstName,
                                   "last_name": lastName,
                                   "month": month,
                                   "year": year ]
        
        let params: [String: Any] = ["account_id": "729EF7D36DB641379CB7B3E14877B4B4",
                                     "method": plan.payableWith,
                                     "data": data,
                                     "test": true]
        
        debugPrint("CREDIT CARD PARAMS ->", params)
        
        return params as [String : AnyObject]
    }
}
