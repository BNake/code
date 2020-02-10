//
//  RetryBackgroundView.swift
//  Zapis
//
//  Created by Nazhmeddin Babakhanov on 11/7/19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

class RetryBackgroundView: UIView {

    var retryEvent: (()->())?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupBackground()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() -> Void {

        addSubviews([messageLabel, retryButton])
        NSLayoutConstraint.activate([
            
            ///Message Label constraint
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),

            ///Retry Button constraint
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            retryButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            retryButton.heightAnchor.constraint(equalToConstant: 40)
        ])

    }

    func setupBackground() -> Void {

        backgroundColor = .white
    }

    @objc func handleRetryEvent() -> Void {
        retryEvent?()
    }

    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 14)
        
        return view
    }()

    lazy var retryButton: UIButton = {
        let view = UIButton()
        view.setTitle("Обновить", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor.gray, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.addTarget(self, action: #selector(handleRetryEvent), for: .touchUpInside)

        return view
    }()
}
