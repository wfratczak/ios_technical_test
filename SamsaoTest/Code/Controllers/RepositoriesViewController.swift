//
//  RepositoriesViewController.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.repositories { (repos, error) in
            
        }
    }
    
    // MARK: Config
    
    private func configureView() {
        
    }

}
