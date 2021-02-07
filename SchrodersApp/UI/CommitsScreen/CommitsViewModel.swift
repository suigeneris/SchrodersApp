//
//  LandingViewModel.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import Foundation

enum CommitViewState: Equatable {

    case loading
    case result
    case error(Error)
    case empty

    static func == (lhs: CommitViewState, rhs: CommitViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.result, .result):
            return true
        case (.error, .error):
            return true
        case (.empty, .empty):
            return true
        default:
            return false
        }
    }
}

protocol CommitViewModelDelegate: class {
    func viewModelDidUpdate(to state: CommitViewState)
}

class CommitsViewModel {

    let dataManager: CommitDataManager
    weak var delegate: CommitViewModelDelegate?
    private(set) var data: [GitCommitModel] = []
    private(set) var viewState: CommitViewState {
        didSet {
            delegate?.viewModelDidUpdate(to: viewState)
        }
    }

    init(dataManager: CommitDataManager) {
        self.dataManager = dataManager
        self.viewState = .empty
    }

    func fetch() {
        viewState = .loading
        dataManager.getResult { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.data = data
                self?.viewState = .result
            case .failure(let error):
                self?.viewState = .error(error)
            }
        }
    }

    func numberOfRows() -> Int {
        return data.count
    }

    func presenter(for row: Int) -> CommitsTableViewCellPresenter? {
        if data.count > row {
            return data[row]
        } else {
            return nil
        }
    }
}

extension GitCommitModel: CommitsTableViewCellPresenter {
    var name: String {
        return authorName
    }

    var message: String {
        return commitMessage
    }

    var imageURL: String? {
        return avatarURL
    }

    var commitDateString: String? {
        return commitDateFormatter.string(from: commitDate) 
    }

}
