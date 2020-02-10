//
//  UITableView+Ext.swift
//  zapis
//
//  Created by Nazhmeddin Babakhanov on 9/9/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    var tableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
    
    static func cellIdentifier() -> String {

        return String.init(describing: self)
    }

}
