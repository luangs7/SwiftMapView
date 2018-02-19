//
//  UIAlertControllerExtension.swift
//
//  Created by Livetouch
//  Updated by Vinicius Gibran
//

import UIKit


import Foundation

public extension UIAlertController {
    
    public func show(animated: Bool = true) {
        
        guard let top = UIApplication.topViewController() else {
            return
        }
        
        if self.presentedViewController == nil {
            top.present(self, animated: animated, completion: nil)
        }
    }
}
