//
//  Endpoints.swift
//  zapis-test
//
//  Created by Babakhanov Nazhmeddin on 4/8/19.
//  Copyright © 2019 Babakhanov Nazhmeddin. All rights reserved.
//

import Alamofire

enum Endpoints: EndPointType {
    
    case getPopular
    case getRecommended
    case getNewlyAdded
    case getDetaile(id: Int)
    
    var baseURL: String {
        return "http://zp.jgroup.kz/rest/v1/salon/"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return  .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
            case .getPopular:
                return "getPopular"
            case .getRecommended:
                return "getRecommended"
            case .getNewlyAdded:
                return "getRecentlyAdded"
            case .getDetaile(let id):
                return "page?id=\(id)"
        }
    }
}
