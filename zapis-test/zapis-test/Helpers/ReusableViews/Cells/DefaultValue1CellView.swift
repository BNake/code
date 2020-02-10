//
//  DefaultValue1CellView.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

//func updateView(with salon: SalonWithFullDescription){
//    
//    tableView.reloadData()
//    
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//    
//    guard let startTime = dateFormatter.date(from: salon.workStartTime), let endTime = dateFormatter.date(from: salon.workEndTime)
//    else { return }
//    
//    dateFormatter.dateFormat = "HH:mm"
//    let startHour = dateFormatter.string(from: startTime)
//    let endHour = dateFormatter.string(from: endTime)
//    
//    timeLabel.text = "С \(startHour) до \(endHour)"
//    
//}

import UIKit

class DefaultValue1CellView: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        accessoryView = nil
    }
}

extension DefaultValue1CellView {

    private func setupViews() -> Void {


    }

    func configure(with title: String) -> Void {
        textLabel?.text = title
        textLabel?.textColor = .black
        textLabel?.font = .systemFont(ofSize: 16)
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        accessoryType = .disclosureIndicator
    }

    func configure(with title: String, subtitle: String) -> Void {
        textLabel?.text = title
        textLabel?.textColor = .black
        textLabel?.font = .systemFont(ofSize: 16)
        detailTextLabel?.text = subtitle
        detailTextLabel?.font = .systemFont(ofSize: 14)
        detailTextLabel?.textColor = UIColor.gray
       separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        selectionStyle = .none

        accessoryType = .disclosureIndicator
    }
}

