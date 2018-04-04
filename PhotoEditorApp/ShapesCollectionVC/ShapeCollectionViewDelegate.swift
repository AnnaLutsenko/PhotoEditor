//
//  ShapeCollectionViewDelegate.swift
//  PhotoEditorApp
//
//  Created by Anna on 04.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class ShapeCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var shapes = [UIImage(named: "triangleIcon"),
                  UIImage(named: "circleIcon"),
                  UIImage(named: "squareIcon")]
    
    var shapeDelegate: ShapeSelectedDelegate!

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        shapeDelegate.didSelectItem(indexPath.row)
        collectionView.isHidden = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ShapeCollectionViewCell.reuseID, for: indexPath) as! ShapeCollectionViewCell
        cell.shapeImgView.image = shapes[indexPath.item]
        return cell
    }
    
}
