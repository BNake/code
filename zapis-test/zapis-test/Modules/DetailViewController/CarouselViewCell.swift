//
//  CarouselViewCell.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 23/12/2019.
//  Copyright © 2019  Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {

//  MARK: UI Properties

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.kf.indicatorType = .activity
        view.contentMode = .scaleAspectFill

        return view
    }()

//  MARK: Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CarouselViewCell")
    }
}

//  MARK: Inner methods
extension CarouselViewCell {

    func setupViews() -> Void {

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func configure(with image: String) -> Void {
        imageView.kf.setImage(with: image.url())
    }

}
