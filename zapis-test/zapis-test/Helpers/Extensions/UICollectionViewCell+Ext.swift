//
//  UICollectionViewCell+Ext.swift
//  zapis
//
//  Created by Nazhmeddin Babakhanov on 9/30/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {

    static func cellIdentifier() -> String {

        return String.init(describing: self)
    }
}

