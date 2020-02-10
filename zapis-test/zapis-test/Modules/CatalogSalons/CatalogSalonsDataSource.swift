//
//  CatalogSalonsDataSource.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//


import UIKit

protocol CatalogSalonsDataSourceDelegate: class {
    func didSelectItem(id: Int) -> Void
}

class CatalogSalonsDataSource: NSObject {
    
    weak var delegate: CatalogSalonsDataSourceDelegate?
    
    public var recomendSalons: [Salon] = []
    public var popularSalons: [Salon] = []
    public var newlyAddedSalons: [Salon] = []
    
    deinit {
        print("DEINIT: CatalogSalonsDataSource")
    }
}

extension CatalogSalonsDataSource:UITableViewDelegate  {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = PaddingLabel(withInsets: 0, 0, 15, 0)
        header.backgroundColor = UIColor.white
        header.font = UIFont.boldSystemFont(ofSize: 17)
        header.textColor = UIColor.black
        switch section {
        case 0:
            header.text = Title.CatalogSalons.recomend
        case 1:
            header.text = Title.CatalogSalons.popular
        default:
            header.text = Title.CatalogSalons.newlyAdded
        }
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt tableView ")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenSize.SCREEN_HEIGHT / 2.5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension CatalogSalonsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomSectionCell.cellIdentifier(), for: indexPath) as? CustomSectionCell
        switch indexPath.section {
        case 0:
            cell!.salons = recomendSalons
        case 1:
            cell!.salons = popularSalons
        default:
            cell!.salons = newlyAddedSalons
        }
        cell?.delegate = self
        return cell!
    }
    
}

extension CatalogSalonsDataSource: CatalogSalonsDataSourceDelegate{
    func didSelectItem(id: Int) {
        print(12435)
        delegate?.didSelectItem(id: id)
    }
}
