//
//  UIColor+Ext.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    class func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        let maxValue : CGFloat = 255
        return UIColor(red: r / maxValue, green: g / maxValue, blue: b / maxValue, alpha: a)
    }
    
    open class var customGrey : UIColor {
        return UIColor.rgba(193, 193, 193, 1)
    }
    
    open class var customLightGrey : UIColor {
        return UIColor.rgba(251, 251, 251, 1)
    }
    
    open class var customPurple : UIColor {
        return UIColor.rgba(157, 181, 240, 1)
    }
}
