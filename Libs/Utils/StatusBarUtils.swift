//
//  StatusBarUtils.swift
//  Farmula-iOS
//
//  Created by Vinicius Gibran on 19/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

class StatusBarUtils {
    //MARK: - Sizes
    static public func getHeight() -> CGFloat {
        let height = UIApplication.shared.statusBarFrame.size.height
        return height
    }
    
    //MARK: - Show & Hide
    ///DPRECATED
    static public func show() {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    static public func hide() {
        UIApplication.shared.isStatusBarHidden = true
    }
    
    static public func isHidden() -> Bool {
        return UIApplication.shared.isStatusBarHidden
    }
    
    //MARK: - Background Color
    static public func setBackgroundToColor(color: UIColor) {
        let view = UIView(frame: CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: 20))
        view.backgroundColor = color
        let window = UIApplication.shared.keyWindow
        if let window = window {
            window.rootViewController?.view.addSubview(view)
        }
    }
    
    static public func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
