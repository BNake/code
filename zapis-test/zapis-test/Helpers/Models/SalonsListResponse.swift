//
//  SalonsListResponse.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//


import Foundation
struct SalonsListResponse: Decodable {
    let salons: [Salon]
}

struct Salon: Decodable {
    let id: Int
    let name: String
    let type: String
    let checkRating: Int
    let pictureUrl: String?
}
