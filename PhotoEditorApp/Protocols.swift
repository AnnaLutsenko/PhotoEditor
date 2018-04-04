//
//  Protocols.swift
//  PhotoEditorApp
//
//  Created by Anna on 02.04.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

protocol ShapeSelectedDelegate {
    func didSelectItem(_ item: Int)
}

protocol ColorDelegate {
    func didSelectColor(color: UIColor)
}
