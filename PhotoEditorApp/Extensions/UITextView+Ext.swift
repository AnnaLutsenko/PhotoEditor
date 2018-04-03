//
//  UITextView+Ext.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

extension UITextView {
    
    func getWidth() -> CGFloat {
        self.sizeToFit()
        return self.contentSize.width
    }
    
    func getHeight() -> CGFloat {
        let lineHeight = self.font?.lineHeight
        let linesCount = self.getCountOfLines()
        return CGFloat(linesCount) * lineHeight!
    }
    
    func getCountOfLines() -> Int {
        let layoutManager:NSLayoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var numberOfLines = 0
        var index = 0
        var lineRange:NSRange = NSRange()
        
        while (index < numberOfGlyphs) {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange);
            numberOfLines = numberOfLines + 1
        }
        return numberOfLines
    }
}
