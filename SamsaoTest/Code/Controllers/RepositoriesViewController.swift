//
//  RepositoriesViewController.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roundedView: UIView!
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadowIfNeeded()
    }
    
    private func addShadowIfNeeded() {
        guard shadowLayer == nil else {return}
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: roundedView.frame, cornerRadius: 0).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = UIColor.white.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 5
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
}

class RepositoriesViewController: UIViewController {

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Const.dateFormat
        return formatter
    }()
    var repositories: [Repository] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRepos()
    }
    
    // MARK: Config
    
    private func configureView() {
        
    }

    // MARK: Networking
    
    private func loadRepos() {
        APIManager.shared.repositories { (repos, error) in
            guard error == nil else {
                self.showErrorAlert(with: "Can not load repositories. Please try again by pull to refresh.")
                return
            }
            guard let repos = repos else {return}
            self.repositories = repos.sorted(by: .name)
            self.tableView.reloadData()
        }
    }
    
    // MARK: Actions
    
    @IBAction func sortAction(_ sender: UISegmentedControl) {
        let sortType = SortType(rawValue: sender.selectedSegmentIndex)!
        repositories = repositories.sorted(by: sortType)
        tableView.reloadData()
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? RepositoryCell else {return}
        let repo = repositories[indexPath.row]
        cell.dateLabel.text = dateFormatter.string(from: repo.updatedAt)
        cell.nameLabel.text = repo.name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self))!
    }
    
}

// MARK: Const

extension RepositoriesViewController {
    
    enum SortType: Int {
        case name = 0, date
    }
    
    struct Const {
        static let dateFormat = "yyyy-MM-dd HH:mm"
    }
}

extension Array where Element: Repository {
    
    func sorted(by type: RepositoriesViewController.SortType) -> [Element] {
        switch type {
        case .name: return sorted{ $0.name < $1.name }
        case .date: return sorted{ $0.updatedAt < $1.updatedAt }
        }
    }
    
}
