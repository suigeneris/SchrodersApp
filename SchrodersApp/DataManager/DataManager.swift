//
//  DataManager.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import Foundation

protocol DataManager: class {

    var url: URL? { get set }

    associatedtype Object: Decodable

    typealias DataManagerCompletion =  (Result<Object, Error>) -> Void

    func getResult(completion: @escaping DataManagerCompletion)

    var decoder: JSONDecoder { get }

    var networkService: NetworkService { get }
}

enum DataManagerError: Error {
    case badUrl
    case noData
}

extension DataManager {

    func getResult(completion: @escaping DataManagerCompletion) {
        guard let url = url else {
            completion(.failure(DataManagerError.badUrl))
            return
        }
        fetchRemoteData(from: url, completion: completion)
    }

    // MARK: Remote Data Methods
    private func fetchRemoteData(from url: URL,
                                 completion: @escaping DataManagerCompletion) {
        networkService.getJSONFromURL(url) { [weak self] reponseData, error  in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = reponseData else {
                return completion(.failure(DataManagerError.noData))
            }
            do {
                guard let results = try self?.decoder.decode(Object.self, from: data) else {
                    return
                }
                completion(.success(results))

            } catch {
                completion(.failure(error))
            }
        }
    }
}
