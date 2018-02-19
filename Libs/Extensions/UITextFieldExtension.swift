//
//  UITextFieldExtension.swift
//  Farmula-iOS
//
//  Created by Vinicius Gibran on 20/03/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

public extension UITextField {
    
    internal enum TextFieldType {
        case email, password, phone, text
    }
    
    
    /**
     Define qual o tipo do UITextField.
     - returns: TextFieldType
     */
    internal func getType() -> TextFieldType {
        if let i = self.accessibilityIdentifier {
            switch i {
            case "password":
                return .password
            case "phone":
                return .phone
            case "email":
                return .email
            default:
                return .text
            }
        }
        return .text
    }
    
    /*
    internal func validate(withType type: TextFieldType, isRequired required : Bool, userFeedback show : Bool, withImage image : UIImageView?) -> Bool {
        let string = self.text!
        if string == "" && required {
            if show {
                self.changeTextFieldStatus(toValid: false, withLabel: "*campo obrigatório")
                image?.validate(isValid: false)
            }
            return false
        }
        
        switch type {
        case .email:
            if (!EmailUtils.isValid(string)) {
                if show {
                    changeTextFieldStatus(toValid: false, withLabel: "Email inválido")
                    image?.validate(isValid: false)
                }
                return false
            }
        case .password:
            if (string.length < 8) {
                if show {
                    changeTextFieldStatus(toValid: false, withLabel: "Senha é muito curta")
                    image?.validate(isValid: false)
                }
                return false
            }
        default:
            break
        }
        changeTextFieldStatus(toValid: true, withLabel: nil)
        image?.validate(isValid: true)
        return true
    } */
    
    
    internal func changeTextFieldStatus(toValid: Bool, withLabel : String?) {
        if toValid {
            setTextWith(color: UIColor.textColor())
            setPlaceholderWith(color: UIColor.placeHolderColor())
            removeLabelAlert()
        } else {
            setTextWith(color: UIColor.alertTextColor())
            setPlaceholderWith(color: UIColor.alertTextColor())
            if let label = withLabel {
                setLabelAlert(text: label)
            }
        }
    }
    
    private func setPlaceholderWith(color: UIColor){
        if let placeholder = self.placeholder {
            let string = placeholder.replacingOccurrences(of: "*", with: "")
            if color == UIColor.alertTextColor() {
                attributedPlaceholder = NSAttributedString(string: string+"*",                                                              attributes: [NSForegroundColorAttributeName: color])
            }
        }
    }
    
    private func setTextWith(color: UIColor){
        textColor = color
    }
    
    private func setLabelAlert(text : String){
        clipsToBounds = false
        for view in subviews {
            let label = view as? UILabel
            if view == label {
                view.removeFromSuperview()
            }
        }
        
        let alertLabel = UILabel(frame: CGRect(x: center.x - 25, y: 13, width: 200, height: 25))
        alertLabel.text = text
        alertLabel.textColor = UIColor.alertTextColor()
        let font = UIFont(name: self.font!.fontName, size: 11)
        alertLabel.font = font
        addSubview(alertLabel)
    }
    
    private func removeLabelAlert() {
        for view in subviews {
            let label = view as? UILabel
            if view == label {
                view.removeFromSuperview()
            }
        }
    }
}
