//
//  Master.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
struct Master: Decodable {
    let id: Int
    let name: String
    let experience: String?
    let profession: String
    let serviceIds: [Int]
}
