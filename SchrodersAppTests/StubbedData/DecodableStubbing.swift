//
//  DecodableStubbing.swift
//  SchrodersAppTests
//
//  Created by Jonathan Aguele on 07/02/2021.
//

import Foundation
@testable import SchrodersApp

protocol DecodableStubbing {
    static func stub<T: Decodable>(from path: String) -> T?
}

extension DecodableStubbing {

    static func stub<T>(from path: String) -> T? where T: Decodable {
        let data = try? Data(contentsOf: URL(fileURLWithPath: path),
                            options: .alwaysMapped)

        let model = try? JSONDecoder().decode(T.self, from: data ?? Data())
        return model
    }
}

extension GitCommitModel: DecodableStubbing {}
