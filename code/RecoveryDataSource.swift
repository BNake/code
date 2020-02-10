//
//  RecoveryDataSource.swift
//
//
//  Created by Nazhmeddin Babakhanov on 10/27/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
import UIKit

class RecoveryDataSource: NSObject {
    
    var params: [String:String]?
    
    weak var delegate: RecoveryDataSourceDelegate?
    var validator: RecoveryValidator?
    private var items: [RecoverySectionType] = []

    init(with typeOfRecovery: RecoverySectionType) {
        validator = RecoveryValidator(typeOfAuthorization: typeOfRecovery)
        self.items = [typeOfRecovery]
        super.init()
    }

    deinit {
        delegate = nil
        print("DEINIT: AuthorizationDataSource")
    }
}

extension RecoveryDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let height = items[indexPath.section].rowItems[indexPath.row].height
        return height
    }
}

extension RecoveryDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let type = items[indexPath.section].rowItems[indexPath.row]

        switch type {
        case .confirmButton, .saveButton, .nextButton:
            return self.buttonCellView(tableView: tableView, indexPath: indexPath, item: items[indexPath.section])
        case .iHaveAccountButton:
            return self.whiteCellView(tableView: tableView, indexPath: indexPath, item: items[indexPath.section])
        case .codeVerification:
            return self.codeVerificationCellView(tableView: tableView, indexPath: indexPath, item: type)
        case .phone:
            return self.defaultTextFieldCellView(tableView: tableView, indexPath: indexPath, item: type)
        case .newOldPassword:
            return self.defaultPasswordsFieldCellView(tableView: tableView, indexPath: indexPath, item: type)
        default:
            return self.messageCellView(tableView: tableView, indexPath: indexPath, item: type)
        }
    }
}

extension RecoveryDataSource {


    private func defaultTextFieldCellView(tableView: UITableView, indexPath: IndexPath, item: RecoveryItem) -> DefaultTextFieldCellView {

        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTextFieldCellView.cellIdentifier(), for: indexPath) as? DefaultTextFieldCellView
        cell?.configure(with: item)
        if item == .phone{
            if let params = params{
                if let value = params[item.key[0]]{
                    cell?.textInput.text = value.formattedNumber()
                    self.validator?.setParameter(key: item.key[0], value: value.formattedNumber(), id: nil)
                }
            }
        }
        cell?.editingChanged = { [weak self] (text, id) in
            self?.validator?.setParameter(key: item.key[0], value: text, id: id)
        }

        return cell!
    }
    
    
    func defaultPasswordsFieldCellView(tableView: UITableView, indexPath: IndexPath, item: RecoveryItem) -> TwoTextFieldCellView {

        let cell = tableView.dequeueReusableCell(withIdentifier: TwoTextFieldCellView.cellIdentifier(), for: indexPath) as? TwoTextFieldCellView
        cell?.configure(with: item)
        
        cell?.editingChanged = { [weak self] (text, id) in
            self?.validator?.setParameter(key: item.key[0], value: text, id: nil)
        }
        

        cell?.editingChanged1 =  { [weak self] (text, id) in
            self?.validator?.setParameter(key: item.key[1], value: text, id: nil)
        }
        

        return cell!
    }

    private func buttonCellView(tableView: UITableView, indexPath: IndexPath, item: RecoverySectionType) -> MainAuthButtonCellView {

        let cell = tableView.dequeueReusableCell(withIdentifier: MainAuthButtonCellView.cellIdentifier(), for: indexPath) as? MainAuthButtonCellView

        cell?.configureToBlue(with: item.rowItems[indexPath.row].placeholder.first!, isLoading: false)

        cell?.didPressed = { [weak self] in
            self?.delegate?.didPressed(with: item)
        }

        return cell!
    }
    
    private func whiteCellView(tableView: UITableView, indexPath: IndexPath, item: RecoverySectionType) -> MainAuthButtonCellView {

        let cell = tableView.dequeueReusableCell(withIdentifier: MainAuthButtonCellView.cellIdentifier(), for: indexPath) as? MainAuthButtonCellView

        cell?.configureToGrey(with: item.rowItems[indexPath.row].placeholder.first!, isLoading: false)

        cell?.didPressed = { [weak self] in
            self?.delegate?.toLoginPressed()
        }

        return cell!
    }

    private func messageCellView(tableView: UITableView, indexPath: IndexPath, item: RecoveryItem) -> MessageCellView {

        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCellView.cellIdentifier(), for: indexPath) as? MessageCellView
        cell?.configure(text: item.placeholder.first!)

        return cell!
    }

    private func codeVerificationCellView(tableView: UITableView, indexPath: IndexPath, item: RecoveryItem) -> CodeVerificationCellView {

        let cell = tableView.dequeueReusableCell(withIdentifier: CodeVerificationCellView.cellIdentifier(), for: indexPath) as? CodeVerificationCellView
        cell?.configure()
        
        cell?.editingChanged = { [weak self] (text) in
            print(text)
            self?.validator?.setParameter(key: item.key[0], value: text, id: nil)
        }

        return cell!
    }
}



