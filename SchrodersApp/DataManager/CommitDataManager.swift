//
//  CommitDataManager.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import Foundation

class CommitDataManager: DataManager {

    typealias Object = [GitCommitModel]

    enum URLQuery {

        static var numberOfItems: URLQueryItem {
            return URLQueryItem(name: "per_page", value: "100")
        }

        static var sha: URLQueryItem {
            return URLQueryItem(name: "sha", value: "f45309246584ebdbc0cd6f4960c3f2103ff76a76")
        }

        static func componentize(for url: URL?) -> URL? {
            guard let url = url else { return nil }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [URLQuery.numberOfItems, URLQuery.sha]
            return components?.url
        }
    }

    var networkService: NetworkService
    var url: URL?
    let decoder = JSONDecoder()

    init(service: NetworkService = NetworkServiceImpl()) {
        self.url = URLQuery.componentize(for: API.commitsEndpoint)
        self.networkService = service
        decoder.dateDecodingStrategy = .iso8601
    }
}
