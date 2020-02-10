//
//  BaseTableViewController.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 23/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class BaseTableViewController: UITableViewController {

    lazy var retryView = RetryBackgroundView()
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        Alamofire.SessionManager.default.session.getAllTasks{ $0.forEach{ $0.cancel() } }
        SVProgressHUD.dismiss()
    }

    func setRetryBackground(with error: String) {
        self.retryView.messageLabel.text = "\(error).\n\(Title.Retry.retry)"
        self.tableView.backgroundView = self.retryView
    }
}
