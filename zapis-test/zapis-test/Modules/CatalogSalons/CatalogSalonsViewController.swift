//
//  CatalogSalonsViewController.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

class CatalogSalonsViewController: UITableViewController {
    
    private var dataSource =  CatalogSalonsDataSource()
    
    private lazy var retryView = RetryBackgroundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchData()
        delegate()
    }
}

extension CatalogSalonsViewController {
    private func setupViews() -> Void {
        
        navigationItem.title = Title.CatalogSalons.title
        
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(CustomSectionCell.self, forCellReuseIdentifier: CustomSectionCell.cellIdentifier())
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    private func delegate(){
        dataSource.delegate = self
    }

}

// Fetching Data
extension CatalogSalonsViewController{
    private func fetchData() -> Void {
    
        // fetchPopularSalons
        Request.shared.getPopularSalons(complitionHandler: { (result: SalonsListResponse) in
            self.tableView.backgroundView = nil
            self.dataSource.popularSalons = result.salons
            self.tableView.reloadData()
        }) { (error) in
            if (self.dataSource.popularSalons.isEmpty == true) {
                self.retryView.messageLabel.text = "\(error). Повторите попытку"
                self.retryView.retryEvent = { [weak self] in
                    self?.fetchData()
                }
                self.tableView.backgroundView = self.retryView

            }
        }
        
        // fetchRecomendsSalons
        Request.shared.getRecommendedSalons(complitionHandler: { (result: SalonsListResponse) in
            self.tableView.backgroundView = nil
            self.dataSource.recomendSalons = result.salons
            self.tableView.reloadData()
        }) { (error) in
            if (self.dataSource.recomendSalons.isEmpty == true) {
                self.retryView.messageLabel.text = "\(error). Повторите попытку"
                self.retryView.retryEvent = { [weak self] in
                    self?.fetchData()
                }
                self.tableView.backgroundView = self.retryView

            }
        }
        
        // fetchNewlyAddedSalons
        Request.shared.getNewlyAddedSalons(complitionHandler: { (result: SalonsListResponse) in
            self.tableView.backgroundView = nil
            self.dataSource.newlyAddedSalons = result.salons
            self.tableView.reloadData()
        }) { (error) in
            if (self.dataSource.recomendSalons.isEmpty == true) {
                self.retryView.messageLabel.text = "\(error). Повторите попытку"
                self.retryView.retryEvent = { [weak self] in
                    self?.fetchData()
                }
                self.tableView.backgroundView = self.retryView

            }
        }
    }
}


extension CatalogSalonsViewController: CatalogSalonsDataSourceDelegate {
    func didSelectItem(id: Int) {
       let viewController = DetailViewController(with: id)
       viewController.edgesForExtendedLayout = .all
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
