//
//  UIView+Ext.swift
//  zapis
//
//  Created by Nazhmeddin Babakhanov on 9/26/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
import UIKit

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {

    func addSubviews(_ views: [UIView]) -> Void {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }

    static func viewIdentifier() -> String {
        return String.init(describing: self.self)
    }

    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0, height: CGFloat = 1) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: height), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -height), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
