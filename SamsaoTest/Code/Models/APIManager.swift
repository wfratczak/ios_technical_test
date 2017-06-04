//
//  APIManager.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIManager {
    
    static let shared = APIManager()
    private init(){}
    
    func repositories(completion: @escaping ReposCompletion) {
        Alamofire.request(Router.repos).responseArray { (response: DataResponse<[Repository]>) in
            completion(response.result.value, response.result.error)
        }
    }

}

private extension APIManager {
    enum Router: URLRequestConvertible {
        case repos
        
        static let baseURL = "https://api.github.com/users"
        
        var method: HTTPMethod {
            switch self {
            case .repos: return .get
            }
        }
        
        var path: String {
            switch self {
            case .repos: return "/samsao/repos"
            }
        }
        
        // MARK: URLRequestConvertible
        
        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return try URLEncoding.default.encode(urlRequest, with: nil)
        }
    }
}

extension APIManager {
    typealias ReposCompletion = (_ repos: [Repository]?, _ error: Error?) -> Void
}
