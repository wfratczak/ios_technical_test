//
//  RepositoryViewController.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {

    var repository: Repository!
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: Config
    
    private func configureView() {
        nameLabel.text = repository.name.replacingOccurrences(of: "samsao/", with: "")
        languageLabel.text = "Language: \(repository.language ?? "Unkown")"
        branchLabel.text = "Default branch: \(repository.defaultBranch ?? "Unkown")"
        forksLabel.text = "Forks number: \(repository.forksNumber ?? 0)"
    }

    // MARK: Actions
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
