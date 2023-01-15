//
//  ResolvableTests.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 11/01/2023.
//

import Foundation
import XCTest
@testable import FindMyPlace

class ResolvableTests: XCTestCase {
    func test_resolvable() {
        let pendingResolvable = Resolvable<[FindMyPlace.Place]>.pending
        let loadingResolvable = Resolvable<[FindMyPlace.Place]>.loading(nil)
        let successResolvable = Resolvable<[FindMyPlace.Place]>.success([])
        let failureResolvable = Resolvable<[FindMyPlace.Place]>.failure(NetworkError.invalidResponse)

        XCTAssert(pendingResolvable.isPending)
        XCTAssert(loadingResolvable.isLoading)
        XCTAssertNil(loadingResolvable.cachedValue)
        XCTAssertEqual(successResolvable.value, [])
        XCTAssertNotNil(successResolvable.value)
        XCTAssertNotNil(failureResolvable.error)
    }
}
