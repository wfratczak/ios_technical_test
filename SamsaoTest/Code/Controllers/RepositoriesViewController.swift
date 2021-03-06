//
//  RepositoriesViewController.swift
//  SamsaoTest
//
//  Created by Wojtek Frątczak on 2017-06-04.
//  Copyright © 2017 Samsao. All rights reserved.
//

import UIKit
import Hero
import DGElasticPullToRefresh

class RepositoriesViewController: UIViewController {

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Const.dateFormat
        return formatter
    }()
    var sortType: SortType = .name
    var repositories: [Repository] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configurePullToRefresh()
        loadRepos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clearAnimationIDs()
    }
    
    // MARK: Config
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    private func configurePullToRefresh() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = .white
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self?.loadRepos()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor((navigationController?.navigationBar.barTintColor)!)
        tableView.dg_setPullToRefreshBackgroundColor(.black)
    }

    // MARK: Networking
    
    private func loadRepos() {
        APIManager.shared.repositories {(repos, error) in
            self.tableView.dg_stopLoading()
            guard error == nil else {
                self.showErrorAlert(with: "Can not load repositories. Please try again by pull to refresh.")
                return
            }
            guard let repos = repos else {return}
            self.repositories = repos.sorted(by: self.sortType)
            self.tableView.reloadData()
        }
    }
    
    // MARK: Actions
    
    @IBAction func sortAction(_ sender: UISegmentedControl) {
        let type = SortType(rawValue: sender.selectedSegmentIndex)!
        sortType = type
        repositories = repositories.sorted(by: type)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? RepositoryViewController, let indexPath = sender as? IndexPath else {return}
        vc.repository = repositories[indexPath.row]
    }
    
    // MARK: Helpers
    
    private func clearAnimationIDs() {
        for cell in tableView.visibleCells {
            guard let cell = cell as? RepositoryCell else {return}
            cell.roundedView.heroID = ""
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! RepositoryCell
        cell.roundedView.heroID = Const.cellAnimationID
        performSegue(withIdentifier: String(describing: RepositoryViewController.self), sender: indexPath)
    }
    
}

// MARK: Const

extension RepositoriesViewController {
    
    enum SortType: Int {
        case name = 0, date
    }
    
    struct Const {
        static let dateFormat = "yyyy-MM-dd HH:mm"
        static let cellAnimationID = "background_view"
    }
}
