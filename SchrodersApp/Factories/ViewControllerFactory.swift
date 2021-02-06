//
//  ViewControllerFactory.swift
//  Schroders
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import Foundation

class ViewControllerFactory {

    static let shared = ViewControllerFactory()
    let dataManagerFactory: DataManagerFactory

    private init() {
        self.dataManagerFactory = DataManagerFactory()
    }

    func landingVC() -> CommitsViewController {
        let viewModel = CommitsViewModel(dataManager: dataManagerFactory.commitDataManager())
        let vc = CommitsViewController(viewModel: viewModel)
        return vc
    }
}
