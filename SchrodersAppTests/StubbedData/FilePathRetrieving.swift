//
//  FilePathRetrieving.swift
//  SchrodersAppTests
//
//  Created by Jonathan Aguele on 07/02/2021.
//

import Foundation
import XCTest

protocol FilePathRetrieving {
     func path(from fileName: String) -> String
}

extension FilePathRetrieving where Self: MockNetworkService {
    func path(from fileName: String) -> String {
        return  Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json")!
    }
}

extension MockNetworkService: FilePathRetrieving {}
