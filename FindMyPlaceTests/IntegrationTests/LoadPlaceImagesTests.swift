//
//  LoadPlaceImagesTests.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 14/01/2023.
//

import Foundation
import XCTest
import Combine
@testable import FindMyPlace

class LoadPlaceImagesTests: XCTestCase {
    var store: Store?
    let services = MockServices()
    let identifier = "random"
    let placeImagesMock = [0, 1].map { PlaceImage(prefix: "\($0)", suffix: "\($0)") }

    override func setUp() {
        store = Store(state: .init(), services: services)
    }

    func test_loads_place_images() {
        XCTAssertNil(store?.state.placeImages[identifier])

        services.mockPlacesService.fetchPlaceImagesStub = { [weak self] identifier in
            return Just(self?.placeImagesMock ?? [])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        store?.dispatch(LoadPlaceImages(id: identifier))
        XCTAssertEqual(store?.state.placeImages[identifier]?.value, placeImagesMock)
    }
}
