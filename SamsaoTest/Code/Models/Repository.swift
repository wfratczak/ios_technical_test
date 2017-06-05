//
//  Repository.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository {
    
    var language: String!
    var defaultBranch: String!
    var forksNumber: Int!
    var name: String!
    var description: String!
    var createdAt: Date!
    var updatedAt: Date!
    
    required init?(map: Map){}
}

// MARK: Mapping

extension Repository: Mappable {
    
    func mapping(map: Map) {
        language <- map["language"]
        defaultBranch <- map["default_branch"]
        name <- map["full_name"]
        forksNumber <- map["forks"]
        updatedAt <- (map["updated_at"], RepositoryDateTransform())
        description <- map["description"]
        createdAt <- (map["created_at"], RepositoryDateTransform())
    }
    
}
