//
//  SendButton.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class SendButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = .customLightGrey
        self.setTitleColor((UIColor.customGrey), for: .normal)
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .customPurple : .customLightGrey
            let titleColor = isEnabled ? UIColor.white : .customGrey
            setTitleColor(titleColor, for: .normal)
        }
    }
}
