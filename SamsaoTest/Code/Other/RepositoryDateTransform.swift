//
//  RepositoryDateTransform.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import Foundation
import ObjectMapper

open class RepositoryDateTransform: DateFormatterTransform {
    
    public init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        super.init(dateFormatter: formatter)
    }
    
}
