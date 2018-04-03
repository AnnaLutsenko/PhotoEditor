//
//  ColorsCollectionViewDelegate.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class ColorsCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var colorDelegate : ColorDelegate?
    
    /**
     Array of Colors that will show while drawing or typing
     */
    var colors = [UIColor.white,
                  UIColor.black,
                  UIColor.init(hex: "228AE6"),
                  UIColor.init(hex: "16AABF"),
                  UIColor.init(hex: "41C057"),
                  UIColor.init(hex: "FAB005"),
                  UIColor.init(hex: "FD7E13"),
                  UIColor.init(hex: "FA5251"),
                  UIColor.init(hex: "FF43AD"),
                  UIColor.init(hex: "BE4ADB")]
    
    override init() {
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        colorDelegate?.didSelectColor(color: colors[indexPath.item])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.reuseID, for: indexPath) as! ColorCollectionViewCell
        cell.colorView.backgroundColor = colors[indexPath.item]
        return cell
    }
    
}
