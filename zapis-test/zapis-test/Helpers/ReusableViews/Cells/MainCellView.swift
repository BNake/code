//
//  MainCellView.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 22/12/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit
import Kingfisher

class MainCellView: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.kf.indicatorType = .activity
        view.contentMode = .scaleAspectFill
        return view
    }()

    lazy var titleView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = UIColor.black
        return view
    }()
    
    lazy var subTitleView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = UIColor.gray
        return view
    }()
}

extension MainCellView {

    func configure(
        with ad: Salon
    ) -> Void {
        imageView.kf.setImage(with: ad.pictureUrl?.url(), placeholder: UIImage.init(named: "4"))
        
        titleView.text = ad.name
        subTitleView.text = ad.type
    }
}

extension MainCellView {

    private func setupViews() -> Void {
        backgroundColor = .white

        addSubviews([imageView, subTitleView, titleView])

        imageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(ScreenSize.SCREEN_HEIGHT/3.5)
            make.center.equalToSuperview()
        }
        
        subTitleView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(5)
            make.left.equalTo(titleView)
        }


        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top).offset(-40)
            make.left.right.equalToSuperview().inset(10)
        }
    }
}
