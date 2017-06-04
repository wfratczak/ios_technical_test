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
    var updateAt: NSDate!
    var description: String!
    var createdAt: NSDate!
    
    required init?(map: Map){}
}

// MARK: Mapping

extension Repository: Mappable {
    
    func mapping(map: Map) {
        language <- map["language"]
        defaultBranch <- map["default_branch"]
        name <- map["full_name"]
        forksNumber <- map["forks"]
        updateAt <- map["updated_at"]
        description <- map["description"]
        createdAt <- map["createdAt"]
    }
    
}
