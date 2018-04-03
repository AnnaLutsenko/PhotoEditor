//
//  PhotoEditorViewController.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class PhotoEditorViewController: UIViewController {
    
    /** holding the 2 imageViews original image and drawing & shapes */
    @IBOutlet weak var canvasView: UIView!
    //T@objc @objc o hold the image
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    //To hold the drawings and shapes
    @IBOutlet weak var canvasImageView: UIImageView!
    
    @IBOutlet weak var colorsView: UIView!
    @IBOutlet weak var colorViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    var colorsCollectionViewDelegate: ColorsCollectionViewDelegate!
    
    @IBOutlet weak var doneUndoBtnsView: UIView!
    @IBOutlet weak var mainBtnsView: UIView!
    @IBOutlet weak var sendBtn: SendButton!
    
    public var colors  : [UIColor] = []
    
    var stickersVCIsVisible = false // for shape
    var swiped = false
    var isDrawing = false
    var isTyping = false
    var drawColor = UIColor.black
    var textColor = UIColor.white
    
    var lastPoint: CGPoint!
    
    var lastPanPoint: CGPoint?
    var lastTextViewTransform: CGAffineTransform?
    var lastTextViewTransCenter: CGPoint?
    var lastTextViewFont: UIFont?
    var activeTextView: UITextView?
    var imageViewToPan: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        followKeyboardNotifications()
        configureCollectionView()
        initController()
    }
    
    func initController() {
        colorsView.addGradientToBackground(colors: [UIColor.black.withAlphaComponent(0), UIColor.black.withAlphaComponent(1)], opacity: 0.2)
    }
    
    func followKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 30, height: 70)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        colorsCollectionView.collectionViewLayout = layout
        colorsCollectionViewDelegate = ColorsCollectionViewDelegate()
        colorsCollectionViewDelegate.colorDelegate = self
        if !colors.isEmpty {
            colorsCollectionViewDelegate.colors = colors
        }
        colorsCollectionView.delegate = colorsCollectionViewDelegate
        colorsCollectionView.dataSource = colorsCollectionViewDelegate
    }
    
    func setImageView(image: UIImage) {
        imageView.image = image
        let size = image.suitableSize(widthLimit: UIScreen.main.bounds.width)
        let emptySpace = UIScreen.main.bounds.height - 160
        let height = (size?.height)! > emptySpace ? emptySpace : size?.height
        imageViewHeightConstraint.constant = height!
        canvasView.layoutIfNeeded()
    }
    
    func mainBnts(isHidden: Bool) {
        mainBtnsView.isHidden = isHidden
        sendBtn.isHidden = isHidden
        doneUndoBtnsView.isHidden = !isHidden
        colorsView.isHidden = !isHidden
    }
    
    @IBAction func addImageBtnTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

}

extension PhotoEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        picker.dismiss(animated: true, completion: nil)
        clearAllDrawing()
        sendBtn.isEnabled = true
        setImageView(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoEditorViewController: ColorDelegate {
    func didSelectColor(color: UIColor) {
        if isDrawing {
            self.drawColor = color
        } else if activeTextView != nil {
            activeTextView?.textColor = color
            textColor = color
        }
    }
}