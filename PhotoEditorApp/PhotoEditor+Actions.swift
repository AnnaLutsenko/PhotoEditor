//
//  PhotoEditorViewController+Actions.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit
import Foundation

extension PhotoEditorViewController {
    
    @IBAction func drawBtnTapped(_ sender: Any) {
        isDrawing = true
        undoBtn.isHidden = false
        colorBtn.setImage(UIImage(named: "pencilIcon"), for: .normal)
        canvasImageView.isUserInteractionEnabled = false
        mainBnts(isHidden: true)
    }
    
    @IBAction func shapeBtnTapped(_ sender: Any) {
        isShape = true
        shapesCollectionView.isHidden = false
        colorBtn.setImage(UIImage(named: "shapeIcon"), for: .normal)
        mainBnts(isHidden: true)
    }
    
    @IBAction func textButtonTapped(_ sender: Any) {
        isTyping = true
        colorBtn.setImage(UIImage(named: "textIcon"), for: .normal)
        let textView = UITextView(frame: CGRect(x: 0, y: canvasImageView.center.y,
                                                width: UIScreen.main.bounds.width, height: 30))
        
        textView.textAlignment = .center
        textView.font = UIFont(name: "Helvetica", size: 30)
        textView.textColor = textColor
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowRadius = 1.0
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.autocorrectionType = .no
        textView.isScrollEnabled = false
        textView.delegate = self
        self.canvasImageView.addSubview(textView)
        addGestures(view: textView)
        textView.becomeFirstResponder()
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        view.endEditing(true)
        canvasImageView.isUserInteractionEnabled = true
        shapesCollectionView.isHidden = true
        mainBnts(isHidden: false)
        undoBtn.isHidden = true
        isDrawing = false
        isShape = false
    }
    
    @IBAction func addImageBtnTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func clearAllDrawing() {
        //clear drawing
        canvasImageView.image = nil
        //clear stickers and textviews
        for subview in canvasImageView.subviews {
            subview.removeFromSuperview()
        }
    }
}
