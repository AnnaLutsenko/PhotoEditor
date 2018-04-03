//
//  CAGradientLayer+Ext.swift
//  PhotoEditorApp
//
//  Created by Anna on 03.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
//        startPoint = CGPoint(x: 0, y: 0)
//        endPoint = CGPoint(x: 1, y: 0)
    }
    
}
