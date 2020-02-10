//
//  DetailViewController.swift
//  zapis-test
//
//  Created by Nazhmeddin Babakhanov on 23/12/2019.
//  Copyright © 2019  Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit
import YandexMapKit

class DetailViewController: BaseTableViewController {
    private var images: [UIImage] = []
    
    private var masters: [Master] = []{
        didSet{
            tableView.reloadData()
        }
    }

    private lazy var backButtonView: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "blueBack"), for: .normal)
        view.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)

        return view
    }()
    
    private lazy var detailHeaderView: CarouselOfImagesView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = CarouselOfImagesView.init(frame: .zero, collectionViewLayout: layout)
        view.frame.size.height = 200
        return view
    }()
    
    private lazy var mapView:YMKMapView = {
        let mapView = YMKMapView()
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.transparentBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.defaulteBar()
    }

    init(with id: Int) {
        super.init(nibName: nil, bundle: nil)
        getDetaile(with: id)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: DetailViewController")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultValue1CellView.cellIdentifier(), for: indexPath) as! DefaultValue1CellView
        cell.configure(with: masters[indexPath.row].name, subtitle: masters[indexPath.row].profession)
        return cell
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Мастера"
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return mapView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func setupLocation(location: Location){
        let salonLocation = YMKPoint(latitude: location.centerY, longitude: location.centerX)
        let cameraPosition = YMKCameraPosition(target: salonLocation, zoom: Float(location.zoom), azimuth: 0, tilt: 0)
        mapView.mapWindow.map.move(
            with: cameraPosition,
            animationType: YMKAnimation(type: YMKAnimationType.linear, duration: 0),
            cameraCallback: nil
        )
    }
}

extension DetailViewController {

    private func setupViews() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButtonView)
        tableView.contentInset = .top(with: -44)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = detailHeaderView
        tableView.tableFooterView = UIView()
        tableView.register(DefaultValue1CellView.self, forCellReuseIdentifier: DefaultValue1CellView.cellIdentifier())
    }

    @objc func dismissPressed() -> Void {
        self.navigationController?.popViewController(animated: true)
    }

}

extension DetailViewController {

    private func getDetaile(with id: Int) -> Void {
        Request.shared.getDetaile(id: id, complitionHandler: { (result) in
            self.setItems(with: result)
            self.tableView.backgroundView = nil
            self.tableView.reloadData()
        }) { (error) in
            self.retryView.retryEvent = { [weak self] in
                self?.getDetaile(with: id)
            }
            self.setRetryBackground(with: error)
        }
    }

    private func setItems(with data: SalonResponse) -> Void {
        self.detailHeaderView.setImages(with: data.salon.pictures)
        self.masters = data.masters ?? []
        if let location = data.location{
             self.setupLocation(location: location)
        }
    }
}
