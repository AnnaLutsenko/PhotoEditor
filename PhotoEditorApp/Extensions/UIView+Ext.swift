//
//  UIView+Ext.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Convert UIView to UIImage
     */
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImageFromMyView!
    }

    func addGradientToBackground(colors: [UIColor], opacity: Float) {
        let gradientLayer = CAGradientLayer(frame: bounds, colors: colors)
        gradientLayer.opacity = opacity
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: frame.size.height)
        layer.insertSublayer(gradientLayer, at: 0) //addSublayer(gradientLayer)
    }
    
}
