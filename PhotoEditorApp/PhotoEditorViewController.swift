//
//  PhotoEditorViewController.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class PhotoEditorViewController: UIViewController {
    
    enum ShapeSelected: Int {
        case triangle = 0, circle, square
    }
    
    /** holding the 2 imageViews original image and drawing & shapes */
    @IBOutlet weak var canvasView: UIView!
    //T@objc @objc o hold the image
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    //To hold the drawings and shapes
    @IBOutlet weak var canvasImageView: UIImageView!
    
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var colorsView: UIView!
    @IBOutlet weak var colorBtn: UIButton!
    @IBOutlet weak var colorViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    var colorsCollectionViewDelegate: ColorsCollectionViewDelegate!
    
    @IBOutlet weak var shapesCollectionView: UICollectionView!
    var shapeCollectionViewDelegate: ShapeCollectionViewDelegate!
    
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var doneUndoBtnsView: UIView!
    @IBOutlet weak var mainBtnsView: UIView!
    @IBOutlet weak var sendBtn: SendButton!
    
    public var colors  : [UIColor] = []
    
    var stickersVCIsVisible = false // for shape
    var swiped = false
    var isShape = false
    var isDrawing = false
    var isTyping = false
    var drawColor = UIColor.black
    var textColor = UIColor.white
    
    var lastPoint: CGPoint!
    var linePath: [(CGPoint, CGPoint)] = []
    var linesArr: [[(CGPoint, CGPoint)]] = []
    var lineColors: [UIColor] = []
    
    var lastPanPoint: CGPoint?
    var lastTextViewTransform: CGAffineTransform?
    var lastTextViewTransCenter: CGPoint?
    var lastTextViewFont: UIFont?
    var activeTextView: UITextView?
    var imageViewToPan: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        followKeyboardNotifications()
        configureColorsCollectionView()
        configureShapesCollectionView()
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
    
    func configureColorsCollectionView() {
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
    
    func configureShapesCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        shapesCollectionView.collectionViewLayout = layout
        shapeCollectionViewDelegate = ShapeCollectionViewDelegate()
        shapeCollectionViewDelegate.shapeDelegate = self
        shapesCollectionView.delegate = shapeCollectionViewDelegate
        shapesCollectionView.dataSource = shapeCollectionViewDelegate
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
        sendBtnIsEnabled()
    }
    
    func deleteView(isHidden: Bool) {
        deleteView.isHidden = isHidden
        sendBtn.isHidden = !isHidden
        colorsView.isHidden = !isHidden
        shapesCollectionView.isHidden = true
    }
    
    func sendBtnIsEnabled() {
        let hasSubviews = canvasImageView.subviews.count > 0
        let hasDrawing = canvasImageView.image != nil
        let hasImg = imageView.image != nil
        
        sendBtn.isEnabled = (hasSubviews || hasDrawing || hasImg)
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
        if isDrawing || isShape {
            self.drawColor = color
        } else if activeTextView != nil {
            activeTextView?.textColor = color
            textColor = color
        }
    }
}

extension PhotoEditorViewController: ShapeSelectedDelegate {
    
    func didSelectItem(_ item: Int) {
        let shape: ShapeSelected = ShapeSelected(rawValue: item)!
        
        switch shape {
        case .triangle:
            createTriangle()
        case .circle:
            createSquare(radius: 50)
        case .square:
            createSquare(radius: 0)
        }
    }
}
