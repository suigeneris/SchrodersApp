//
//  Configuration.swift
//  SchrodersApp
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String, bundle: Bundle = .main) throws -> T where T: LosslessStringConvertible {
        guard let config = bundle.object(forInfoDictionaryKey: "Configuration") as? [String: Any],
        let object = config[key] else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }

    // The network time interval
    static var requestTimeout: TimeInterval { return 10 }
}

enum API {
    private static var respositoriesURL: URL {
        return try! URL(string: Configuration.value(for: "REPOSITORIES_API"))!
    }

    static var commitsEndpoint: URL {
        let commitPath = "commits"
        return API.respositoriesURL.appendingPathComponent(commitPath)
    }
}
