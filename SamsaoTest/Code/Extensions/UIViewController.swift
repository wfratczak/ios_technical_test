//
//  UIViewController.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(with message: String) {
        let errorAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
    }
    
}
