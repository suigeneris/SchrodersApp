//
//  LandingViewModel.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import Foundation

class LandingViewModel {

    let dataManager: CommitDataManager

    init(dataManager: CommitDataManager) {
        self.dataManager = dataManager
    }

    func fetch() {
        dataManager.getResult { (result) in
            print(result)
        }
    }
}
