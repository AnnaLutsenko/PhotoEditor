//
//  UIImage+Ext.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     Suitable size for specific height or width to keep same image ratio
     */
    func suitableSize(heightLimit: CGFloat? = nil,
                      widthLimit: CGFloat? = nil )-> CGSize? {
        
        if let height = heightLimit {
            
            let width = (height / self.size.height) * self.size.width
            
            return CGSize(width: width, height: height)
        }
        
        if let width = widthLimit {
            let height = (width / self.size.width) * self.size.height
            return CGSize(width: width, height: height)
        }
        
        return nil
    }
    
    // rotate image
    
    func rotatedImageWithTransform(_ rotation: CGAffineTransform, croppedToRect rect: CGRect) -> UIImage {
        let rotatedImage = rotatedImageWithTransform(rotation)
        
        let scale = rotatedImage.scale
        let cropRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        
        let croppedImage = rotatedImage.cgImage?.cropping(to: cropRect)
        let image = UIImage(cgImage: croppedImage!, scale: self.scale, orientation: rotatedImage.imageOrientation)
        return image
    }
    
    fileprivate func rotatedImageWithTransform(_ transform: CGAffineTransform) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: size.width / 2.0, y: size.height / 2.0)
        context?.concatenate(transform)
        context?.translateBy(x: size.width / -2.0, y: size.height / -2.0)
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage!
    }
}
