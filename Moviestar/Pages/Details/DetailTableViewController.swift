//
//  DetailTableViewController.swift
//  Moviestar
//
//  Created by Victor Pedersen on 10/11/2021.
//

import UIKit
import Entities

final class DetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    let cellIdentifier = "detailCell"
    var movie: MovieCell.ViewModel
    
    // MARK: - ViewDidLoad
    init(movie: MovieCell.ViewModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        title = movie.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground(viewController: self)
    }
    
    // MARK: - Handlers
    private func configureView() {
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    
    private func configureCells() {
        tableView.register(DetailCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We only want to display the single detail cell once.
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailCell
        cell.movie = movie
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
