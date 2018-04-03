//
//  ColorCollectionViewCell.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    static let reuseID = "reuseColorCollectionViewCell"
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.layer.borderWidth = 1.0
        colorView.layer.borderColor = UIColor.white.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
                let previouTransform =  colorView.transform
                UIView.animate(withDuration: 0.2,
                               animations: {
                                self.colorView.transform = self.colorView.transform.scaledBy(x: 1.3, y: 1.3)
                },
                               completion: { _ in
                                UIView.animate(withDuration: 0.2) {
                                    self.colorView.transform  = previouTransform
                                    self.colorView.layer.borderWidth = 3
                                }
                })
            } else {
                // animate deselection
                self.colorView.layer.borderWidth = 1
            }
            
        }
    }
    
}
