//
//  RecoveryValidator.swift
//  
//
//  Created by Nazhmeddin Babakhanov on 17/01/2020.
//  Copyright © 2020 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation

class RecoveryValidator {

    private var typeOfRecovery: RecoverySectionType = .phoneEnter
    private var params: [String : String] = [:]
    private var typedText: [String : String] = [:]

    init(typeOfAuthorization: RecoverySectionType) {
        self.typeOfRecovery = typeOfAuthorization
    }

    func setParameter(key: String, value: String, id: Int?) -> Void {
        params[key] = (id == nil) ? value : "\(id!)"
        typedText[key] = value
        print("Typed text: \(typedText)")
        print("Params text: \(params)")
    }
}

extension RecoveryValidator {

    func isValid(
        complitionSucces: @escaping (( [String : String])->()),
        complitionError: @escaping ((String)->())
    ) -> Void {

        switch typeOfRecovery {
        case .phoneEnter:
            isValidUserRecoverySendSms(withSuccess: { 
                complitionSucces(self.params)
            }) { (message) in complitionError(message) }
        case .codeVerification:
            isValidUsersVerifySms(withSuccess: {
                complitionSucces(self.params)
            }) { (message) in complitionError(message) }
        default:
            isValidUsersForgotPasswordChange(withSuccess: {
                complitionSucces(self.params)
            }) { (message) in complitionError(message) }
        }
    }
    
    private func isValidUsersVerifySms(
        withSuccess: @escaping (()->()),
        withError: @escaping ((String)->())
    ) -> Void {

        guard let phone = typedText[Key.Recovery.phone], (phone.count == 18) else {
            withError("Некорректный номер телефона")
            return
        }
        
        guard let code = typedText[Key.Recovery.code], (code.count == 4) else {
            withError("Некорректный код")
            return
        }
        
        var formattedPhone = typedText[Key.Recovery.phone]
        formattedPhone = formattedPhone?.replacingOccurrences(of: " ", with: "")
        formattedPhone = formattedPhone?.replacingOccurrences(of: "(", with: "")
        formattedPhone = formattedPhone?.replacingOccurrences(of: ")", with: "")

        params[Key.Recovery.phone] = formattedPhone
        
        withSuccess()
        
    }
    
    
    private func isValidUserRecoverySendSms(
        withSuccess: @escaping (()->()),
        withError: @escaping ((String)->())
    ) -> Void {

        guard let phone = typedText[Key.Recovery.phone], (phone.count == 18) else {
            withError("Некорректный номер телефона")
            return
        }
        
        var formattedPhone = typedText[Key.Recovery.phone]
        formattedPhone = formattedPhone?.replacingOccurrences(of: " ", with: "")
        formattedPhone = formattedPhone?.replacingOccurrences(of: "(", with: "")
        formattedPhone = formattedPhone?.replacingOccurrences(of: ")", with: "")

        params[Key.Recovery.phone] = formattedPhone
        withSuccess()
        
    }
    
    private func isValidUsersForgotPasswordChange(
        withSuccess: @escaping (()->()),
        withError: @escaping ((String)->())
    ) -> Void {

        
        guard let newPassword = typedText[Key.Recovery.newPassword], newPassword.count > 7 else {
            withError("Размер пароля должен быть не менее 8")
            return
        }
        guard let repeatPassword = typedText[Key.Recovery.repeatPassword], newPassword == repeatPassword else {
            withError("Пароли не совпадают")
            return
        }

        withSuccess()
        
    }

    private func isValidUserRegistration(
        withSuccess: @escaping (()->()),
        withError: @escaping ((String)->())
    ) -> Void {

//        guard let phone = typedText[Key.Recovery.phone], (phone.count == 18) else {
//            withError("Некорректный номер телефона")
//            return
//        }
//        guard let name = typedText[Key.Recovery.code], (name.isEmpty == false) else {
//            withError("Заполните код")
//            return
//        }
//        guard let surname = typedText[Key.Recovery.password], (surname.isEmpty == false)  else {
//            withError("Заполните фамилию")
//            return
//        }
//        guard let email = typedText[Key.Authorization.email], (email.isValidEmail() == true) else {
//            withError("Некорректная почта")
//            return
//        }
//        guard let newPassword = typedText[Key.Authorization.newPassword], newPassword.count > 7 else {
//            withError("Размер пароля должен быть не менее 8")
//            return
//        }
//        guard let repeatPassword = typedText[Key.Authorization.repeatPassword], newPassword == repeatPassword else {
//            withError("Пароли не совпадают")
//            return
//        }
//
//        var formattedPhone = typedText[Key.Authorization.phone]
//        formattedPhone = formattedPhone?.replacingOccurrences(of: " ", with: "")
//        formattedPhone = formattedPhone?.replacingOccurrences(of: "(", with: "")
//        formattedPhone = formattedPhone?.replacingOccurrences(of: ")", with: "")
////        formattedPhone = formattedPhone?.replacingOccurrences(of: "+", with: "")
//        formattedPhone?.removeFirst()
//
//        params[Key.Authorization.phone] = formattedPhone
//
        withSuccess()
    }
}

