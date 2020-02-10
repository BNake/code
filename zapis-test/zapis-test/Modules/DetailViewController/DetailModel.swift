//
//  DetailModel.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 23/12/2019.
//  Copyright © 2019  Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
import UIKit

enum DetailItem {

    case masters
    case location

    var height: CGFloat {
        switch self {
        default:
            return 44
        }
    }

    var placeholder: [String] {
        switch self {
        default:
            return []
        }
    }
}


enum DetailSectionType {

    case main(items: [String])
    case detail(items: [String])
    case owner(items: [String])
    case button

    var rowItems: [String] {
        switch self {
        case .main(let items):
            return items
        case .detail(let items):
            return items
        case .owner(let items):
            return items
        default:
            return []
        }
    }

    var height: CGFloat {
        switch self {
        case .detail:
            return 20
        default:
            return .zero
        }
    }
}

