//
//  String+Ext.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 23/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

extension String {
    func url() -> URL? {
        let path = "http://zp.jgroup.kz\(self)"
        return URL(string: path)
    }
}
