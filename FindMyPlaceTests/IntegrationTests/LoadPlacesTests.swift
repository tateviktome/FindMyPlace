//
//  LoadPlacesTests.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 13/01/2023.
//

import Foundation
import XCTest
import Combine
@testable import FindMyPlace

class LoadPlacesTests: XCTestCase {
    var store: Store?
    let services = MockServices()
    let placesIdentifier = PlacesIdentifier(type: "coffee", radius: 2)
    let placesMock = [0, 1].map { Place(id: "\($0)", name: "\($0)", location: .init(formattedAddress: "")) }

    override func setUp() {
        store = Store(state: .init(), services: services)
    }

    func test_loads_places() {
        XCTAssertNil(store?.state.places[placesIdentifier])

        services.mockPlacesService.fetchPlacesStub = { [weak self] identifier in
            return Just(self?.placesMock ?? [])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        store?.dispatch(LoadPlaces(identifier: placesIdentifier))
        XCTAssertEqual(store?.state.places[placesIdentifier]?.value, placesMock)
    }
}
