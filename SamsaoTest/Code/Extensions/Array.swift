//
//  Array.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import Foundation

extension Array where Element: Repository {
    
    func sorted(by type: RepositoriesViewController.SortType) -> [Element] {
        switch type {
        case .name: return sorted{ $0.name < $1.name }
        case .date: return sorted{ $0.updatedAt > $1.updatedAt }
        }
    }
    
}
