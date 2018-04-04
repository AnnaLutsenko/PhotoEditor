//
//  PhotoEditor+Shapes.swift
//  PhotoEditorApp
//
//  Created by Anna on 04.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

extension PhotoEditorViewController {
    
    func createSquare(radius: Int) {
        
        let view = UIView()
        view.frame.size = CGSize(width: 100, height: 100)
        view.center = canvasImageView.center
        
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = drawColor.cgColor
        view.layer.borderWidth = 5
        view.layer.cornerRadius = CGFloat(radius)
        self.canvasImageView.addSubview(view)
        //Gestures
        addGestures(view: view)
    }
    
    func createTriangle() {
        
        let view = UIView()
        view.frame.size = CGSize(width: 100, height: 100)
        view.center = canvasImageView.center
        view.backgroundColor = UIColor.clear
        // drawing triangle
        let path = UIBezierPath()
        path.move(to: CGPoint(x: view.frame.width/2, y: view.frame.height/2-50))
        path.addLine(to: CGPoint(x: view.frame.width/2-50, y: view.frame.size.height/2+50))
        path.addLine(to: CGPoint(x: view.frame.width/2+50, y: view.frame.size.height/2+50))
        path.close()
        
        let trLayer = CAShapeLayer()
        trLayer.path = path.cgPath
        trLayer.lineWidth = 5
        trLayer.strokeColor = drawColor.cgColor
        trLayer.fillColor = nil
        view.layer.addSublayer(trLayer)
        
        self.canvasImageView.addSubview(view)
        //Gestures
        addGestures(view: view)
    }
}
