//
//  Service.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation

struct Service: Decodable {
    let id: Int
    let name: String
    let price: Int
    let priceStr: String
    let duration: Int
//    let description: String
    let categoryId: Int
    
}
