//
//  SalonResponse.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation

struct SalonResponse: Decodable {
    let salon: SalonWithFullDescription
    let masters: [Master]?
    let services: [Service]
    let location: Location?
}

struct SalonWithFullDescription: Decodable {
    let id: Int
    let category: String
    let name: String
    let address: String
    let workStartTime: String
    let workEndTime: String
    let averageRating: Float
    let reviewCount: Int
    let instagramProfile: String
    let phoneNumbers: [String]
    let avatarUrl: String
    let pictures: [String]
}
