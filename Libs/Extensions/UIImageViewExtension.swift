//
//  UITextFieldExtension.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 20/03/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    public func tintImageViewWith(color: UIColor){
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
    public func setImageWith(url: String,
                       placeholderImage: Image? = nil,
                       optionsInfo: KingfisherOptionsInfo? = nil,
                       progressBlock: DownloadProgressBlock? = nil,
                       completionHandler: CompletionHandler? = nil) /*-> RetrieveImageTask?*/ {
        
        if let url = URL(string: url) {
            
            _ = self.kf.setImage(with: url, placeholder: placeholderImage, options: optionsInfo, progressBlock: progressBlock, completionHandler: completionHandler)
        } else {
          debugPrint("<UIImageView.setUrl> invalid url \(url)")
        }
    }
}
