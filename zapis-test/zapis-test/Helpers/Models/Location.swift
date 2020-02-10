//
//  Location.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 24/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation

struct Location: Decodable {
    let type: String
    let markerX: Float
    let markerY: Float
    let centerX: Double
    let centerY: Double
    let zoom: Int
    
}
