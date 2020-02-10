//
//  Worker.swift
//  zapis-test
//
//  Created by Babakhanov Nazhmeddin on 4/8/19.
//  Copyright © 2019 Babakhanov Nazhmeddin. All rights reserved.
//


import Foundation
import SVProgressHUD

class Request{

    private let networkManager: NetworkManager = NetworkManager()
    static let shared = Request()

    init() {
        
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.gray)
        SVProgressHUD.setBackgroundColor(.clear)
    }
}


//  MARK: GET REQUESTS
extension  Request {

    func getPopularSalons(
        complitionHandler: @escaping ((SalonsListResponse)->Void),
        complitionHandlerError: @escaping ((String) -> Void)
    ) -> Void {


        let endpoints = Endpoints.getPopular
        SVProgressHUD.show()
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<SalonsListResponse>) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                complitionHandlerError(error)
            case .success(let salons):
                complitionHandler(salons)
            }
        }
    }
    
    func getRecommendedSalons(
        complitionHandler: @escaping ((SalonsListResponse)->Void),
        complitionHandlerError: @escaping ((String) -> Void)
    ) -> Void {


        let endpoints = Endpoints.getRecommended
        SVProgressHUD.show()
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<SalonsListResponse>) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                complitionHandlerError(error)
            case .success(let categories):
                complitionHandler(categories)
            }
        }
    }
    
    func getNewlyAddedSalons(
        complitionHandler: @escaping ((SalonsListResponse)->Void),
        complitionHandlerError: @escaping ((String) -> Void)
    ) -> Void {


        let endpoints = Endpoints.getNewlyAdded
        SVProgressHUD.show()
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<SalonsListResponse>) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                complitionHandlerError(error)
            case .success(let categories):
                complitionHandler(categories)
            }
        }
    }

}

//  MARK: POST REQUESTS
extension Request {
    
    func getDetaile(
        id: Int,
        complitionHandler: @escaping ((SalonResponse)->Void),
        complitionHandlerError: @escaping ((String) -> Void)
    ) -> Void {

        let endpoints = Endpoints.getDetaile(id: id)
        SVProgressHUD.show()
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<SalonResponse>) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                complitionHandlerError(error)
            case .success(let detaile):
                complitionHandler(detaile)
            }
        }
    }
    

    
}
