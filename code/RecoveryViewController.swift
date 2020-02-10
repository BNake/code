//
//  RecoveryViewController.swift
//
//
//  Created by Nazhmeddin Babakhanov on 10/27/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

protocol RecoveryDataSourceDelegate: class {

    func didPressed(with type: RecoverySectionType) -> Void
    func toLoginPressed() -> Void
}

class RecoveryViewController: UITableViewController {

    var token = ""
    
    var dataSource: RecoveryDataSource?
    private var typeOfRecovery: RecoverySectionType?

    private lazy var dismissButtonView: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "dismiss"), for: .normal)
        view.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)

        return view
    }()

    init(typeOfRecovery: RecoverySectionType) {
        dataSource = RecoveryDataSource(with: typeOfRecovery)
        self.typeOfRecovery = typeOfRecovery
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.transparentBarSmall()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.transparentBar()
    }

}

extension RecoveryViewController {

    private func setupViews() -> Void {

        navigationItem.title = Title.Recovery.recovery
        dataSource?.delegate = self
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        tableView.register(MainAuthButtonCellView.self, forCellReuseIdentifier: MainAuthButtonCellView.cellIdentifier())
        tableView.register(DefaultTextFieldCellView.self, forCellReuseIdentifier: DefaultTextFieldCellView.cellIdentifier())
        tableView.register(TwoTextFieldCellView.self, forCellReuseIdentifier: TwoTextFieldCellView.cellIdentifier())
        tableView.register(CodeVerificationCellView.self, forCellReuseIdentifier: CodeVerificationCellView.cellIdentifier())
        tableView.register(MessageCellView.self, forCellReuseIdentifier: MessageCellView.cellIdentifier())
    }

    @objc func dismissPressed() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RecoveryViewController: RecoveryDataSourceDelegate {

    func didPressed(with type: RecoverySectionType) -> Void {
        
        switch type {
        case .phoneEnter:
            self.postSendSms()
        case .codeVerification:
            self.checkCode()
        default:
            self.changePassword()
        }
    }
    
    func toLoginPressed() -> Void {
        navigationController?.popToRootViewController(animated: false)
    }
}

extension RecoveryViewController {

    private func postSendSms() -> Void {
        dataSource?.validator?.isValid(complitionSucces: { params in
            print(params)
            
            Request.shared.postUsersForgotPasswordSendCode(params: params, complitionHandler: {
                let viewController = RecoveryViewController(typeOfRecovery: .codeVerification)
                viewController.dataSource?.params = params
                self.navigationController?.pushViewController(viewController, animated: true)
            }) { (error) in
                self.showAlert(title: "Ошибка", msg: error)
            }
        }, complitionError: { (message) in
            self.showAlert(title: "Ошибка", msg: message)
        })
    }
    
    private func checkCode() -> Void{
        dataSource?.validator?.isValid(complitionSucces: { params in
            let number = Int(params[Key.Recovery.code]!)
            let phone = params[Key.Recovery.phone]
            
            Request.shared.postUsersVerify(params: [ Key.Recovery.phone: phone!, Key.Recovery.code: number!], complitionHandler: { token in
                print(token)
                
                let viewController = RecoveryViewController(typeOfRecovery: .passwordRecovery)
                viewController.token = token
                self.navigationController?.pushViewController(viewController, animated: true)
            }) { (error) in
                self.showAlert(title: "Ошибка", msg: error)
            }
        }, complitionError: { (message) in
            self.showAlert(title: "Ошибка", msg: message)
        })
    }
    
    private func changePassword() -> Void{
        dataSource?.validator?.isValid(complitionSucces: { params in
            let password = params[Key.Recovery.newPassword]
            Request.shared.postUsersForgotPasswordChange(params: [Key.Recovery.password: password!] , token: self.token , complitionHandler: {
                self.navigationController?.popToRootViewController(animated: false)
            }) { (error) in
                self.showAlert(title: "Ошибка", msg: error)
            }
        }, complitionError: { (message) in
            self.showAlert(title: "Ошибка", msg: message)
        })
    }
}
