//
//  CommitsViewModelTests.swift
//  SchrodersAppTests
//
//  Created by Jonathan Aguele on 07/02/2021.
//

import Foundation
import Quick
import Nimble

@testable import SchrodersApp

class CommitViewModelTests: QuickSpec {

    override func spec() {

        var sut: CommitsViewModel!
        var dataManager: CommitDataManager!
        var service: MockNetworkService!

        context("CommitViewModel") {

            beforeEach {
                service = MockNetworkService()
                dataManager = CommitDataManager(service: service)
                sut = CommitsViewModel(dataManager: dataManager)
            }

            describe("Fetch data succeeds") {
                beforeEach {
                    service.expectedResultType = .success
                    sut.fetch()
                }

                it("should set the data array") {
                    expect(sut.data.count).to(equal(10))
                }

                it("should set view state to success") {
                    expect(sut.viewState).to(equal(CommitViewState.result))
                }

                it("should return to correct number of rows") {
                    expect(sut.numberOfRows).to(equal(10))
                }

                it("should contain the correct data") {
                    let presenter = sut.presenter(for: 6)
                    expect(presenter?.name).to(equal("Saleem Abdulrasool"))
                    expect(presenter?.commitDateString).to(equal("12-12-2018"))
                    expect(presenter?.imageURL).to(equal("https://avatars.githubusercontent.com/u/63311?v=4"))
                }
            }

            describe("Fetch data fails") {
                beforeEach {
                    service.expectedResultType = .error
                    sut.fetch()
                }

                it("should set the data array") {
                    expect(sut.data.count).to(equal(0))
                }

                it("should set view state to success") {
                    expect(sut.viewState).to(equal(CommitViewState.error(service.expectedError)))
                }

                it("should return to correct number of rows") {
                    expect(sut.numberOfRows).to(equal(0))
                }
            }
        }
    }
}
