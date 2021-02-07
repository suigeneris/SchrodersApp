//
//  CommitViewControllerSnapshotTests.swift
//  SchrodersAppTests
//
//  Created by Jonathan Aguele on 06/02/2021.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import SchrodersApp

class CommitViewControllerSnapshotTests: XCTestCase {

    var service: MockNetworkService!
    var dataManager: CommitDataManager!
    var viewModel: CommitsViewModel!
    var sut: CommitsViewController!

    override func setUp() {
        super.setUp()
        service = MockNetworkService()
        dataManager = CommitDataManager(service: service)
        viewModel = CommitsViewModel(dataManager: dataManager)
        sut = CommitsViewController(viewModel: viewModel)
        isRecording = true
    }

    func testViewControllerEmptyState() {
        assertSnapshot(matching: self.sut, as: .image)
    }

    func testViewControllerLoadingState() {
        service.expectedResultType = .loading
        self.sut.fetchButtonPressed(self)
        assertSnapshot(matching: self.sut, as: .image)
    }

    func testViewControllerResultState() {
        service.expectedResultType = .success
        self.sut.fetchButtonPressed(self)
        assertSnapshot(matching: self.sut, as: .image)
    }
}
