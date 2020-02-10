//
//  UIEdgeInsets+Ext.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit


extension UIEdgeInsets {

    static func left(with value: CGFloat) -> UIEdgeInsets {

        let edgeInsets = UIEdgeInsets.init(top: 0, left: value, bottom: 0, right: 0)
        return edgeInsets
    }

    static func right(with value: CGFloat) -> UIEdgeInsets {

        let edgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: value)
        return edgeInsets
    }

    static func top(with value: CGFloat) -> UIEdgeInsets {

        let edgeInsets = UIEdgeInsets.init(top: value, left: 0, bottom: 0, right: 0)
        return edgeInsets
    }

    static func bottom(with value: CGFloat) -> UIEdgeInsets {

        let edgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: value, right: 0)
        return edgeInsets
    }
}
