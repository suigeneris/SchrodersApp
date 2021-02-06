//
//  LandingViewController.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import UIKit

class CommitsViewController: UIViewController {

    let viewModel: CommitsViewModel
    private lazy var loadingViewController = LoadingViewController()
    private lazy var emptyStateViewController = EmptyStateViewController()
    private lazy var errorViewController = EmptyStateViewController()
    private(set) var currentChildViewController: UIViewController?

    var commitsView: CommitsView {
        guard let commitsView = view as? CommitsView else { return CommitsView() }
        return commitsView
    }

    init(viewModel: CommitsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: CommitsView.identifier, bundle: Bundle.main)
        self.viewModel.delegate = self
        setupCommitsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(forViewState: viewModel.viewState)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCommitsView() {
        commitsView.tableView.delegate = self
        commitsView.tableView.dataSource = self
    }

    @IBAction func fetchButtonPressed(_ sender: Any) {
        viewModel.fetch()
    }
}

extension CommitsViewController {
    private func updateView(forViewState viewState: CommitViewState) {
        switch viewState {
        case .loading:
            setActiveChildViewController(viewController: loadingViewController)
        case .result:
            reload()
        case .empty:
            setActiveChildViewController(viewController: emptyStateViewController)
        case .error(let error):
            errorViewController.error = error
            setActiveChildViewController(viewController: errorViewController)

        }
    }

    private func setActiveChildViewController(viewController: UIViewController?) {
        removeEmbededChildViewControllerIfNeeded()
        guard let viewController = viewController else { return }
        embedController(viewController, layout: .custom({ (view) in
            view.snp.makeConstraints { [weak self] (make) in
                guard let strongSelf = self else { return }
                make.edges.equalTo(strongSelf.commitsView.tableView.snp.edges)
            }
        }))
        currentChildViewController = viewController
    }

    private func removeEmbededChildViewControllerIfNeeded() {
        guard let viewController = currentChildViewController else { return }
        removeEmbeddedController(viewController)
        currentChildViewController = nil
    }

    private func reload() {
        DispatchQueue.main.async {
            self.removeEmbededChildViewControllerIfNeeded()
            self.commitsView.tableView.reloadData()
        }
    }
}

extension CommitsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitsTableViewCell.identifier,
                                                       for: indexPath) as? CommitsTableViewCell,
              let presenter = viewModel.presenter(for: indexPath.row)
        else { return UITableViewCell() }
        cell.update(with: presenter)
        return cell
    }
}

extension CommitsViewController: CommitViewModelDelegate {
    func viewModelDidUpdate(to state: CommitViewState) {
        updateView(forViewState: state)
    }
}
