//
//  MockNetworkService.swift
//  SchrodersAppTests
//
//  Created by Jonathan Aguele on 06/02/2021.
//

import Foundation

@testable import SchrodersApp

class MockNetworkService: NetworkService {

    enum ExpectedResultType {
        case success
        case error
        case empty
        case loading
    }

    var expectedResultType: ExpectedResultType = .success

    func getJSONFromURL(_ url: URL, completion: @escaping (Data?, Error?) -> Void) {

        switch expectedResultType {
        case .success:
            let data = try? Data(contentsOf: URL(fileURLWithPath: self.path(from: "GitCommitModel")),
                                options: .alwaysMapped)
            completion(data, nil)
        case .error:
            print("")
        case .empty:
            print("")
        case .loading:
            print("")
        }
    }
}
