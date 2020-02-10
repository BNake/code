//
//  RecoveryModel.swift
//  
//
//  Created by Nazhmeddin Babakhanov on 10/27/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
import UIKit

enum RecoveryItem {

    case phone
    case newOldPassword
    case codeVerification
    case confirmButton
    case saveButton
    case nextButton
    case messageOfPhone
    case messageOfPassword
    case iHaveAccountButton

    var height: CGFloat {
        switch self {
        default:
            return UITableView.automaticDimension
        }
    }

    var placeholder: [String] {
        switch self {
        case .phone:
            return [Title.Recovery.phone]
        case .newOldPassword:
            return [Title.Recovery.newPassword, Title.Recovery.repeatPassword]
        case .confirmButton:
            return [Title.Recovery.confirmButton]
        case .saveButton:
            return [Title.Recovery.saveButton]
        case .nextButton:
            return [Title.Recovery.nextButton]
        case .messageOfPhone:
            return [Title.Recovery.messageOfPhone]
        case .messageOfPassword:
            return [Title.Recovery.messageOfPassword]
        case .iHaveAccountButton:
            return [Title.Recovery.iHaveAccountButton]
        default:
            return []
        }
    }

    var inputView: TypeOfInput {
        switch self {
        case .phone, .codeVerification:
            return .phonePad
        case .newOldPassword:
            return .passwordPad
        default:
            return .defaultPad
        }
    }

    var pickerDataSource: [String] {
        switch self {
        default:
            return []
        }
    }
    
    var key: [String]{
        switch self {
        case .phone:
            return [Key.Recovery.phone]
        case .newOldPassword:
            return [Key.Recovery.newPassword, Key.Recovery.repeatPassword]
        case .codeVerification:
            return [Key.Recovery.code]
        default:
            return [Key.empty]
        }
    }
}


enum RecoverySectionType {

    case phoneEnter
    case codeVerification
    case passwordRecovery

    var rowItems: [RecoveryItem] {
        switch self {
        case .phoneEnter:
            return [
                .messageOfPhone,
                .phone,
                .nextButton,
                .iHaveAccountButton
            ]
        case .codeVerification:
            return [
                .phone,
                .codeVerification,
                .confirmButton,
                .iHaveAccountButton
            ]
        default:
            return [
                .messageOfPassword,
                .newOldPassword,
                .saveButton
            ]
        }
    }

    var height: CGFloat {
        switch self {
        default:
            return .zero
        }
    }
}
