//
//  ReducerTests.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 11/01/2023.
//

import Foundation
import CoreLocation
import XCTest
@testable import FindMyPlace

class ReducerTests: XCTestCase {
    func testLoadPlacesReducer() {
        let places = [FindMyPlace.Place]()
        var next = AppState().places
        let placesIdentifier = PlacesIdentifier(type: "coffee", radius: 1)

        let actions = [
            Action.loadPlaces(placesIdentifier, .success(places)),
            .loadPlaces(placesIdentifier, .failure(NetworkError.invalidResponse)),
            .loadPlaces(placesIdentifier, .pending),
            .loadPlaces(placesIdentifier, .loading(nil))
        ]

        actions.forEach { action in
            let previous = next
            next = Reducers.placesReducer(next, action)
            if case let .loadPlaces(_, result) = action {
                XCTAssertEqual(next[placesIdentifier], result)
            } else {
                XCTAssertEqual(previous, next)
            }
        }
    }

    func testLoadPlaceImagesReducer() {
        let placeImages = [FindMyPlace.PlaceImage]()
        let identifier = "random"
        var next = AppState().placeImages

        let actions = [
            Action.loadPlaceImages(identifier, .success(placeImages)),
            .loadPlaceImages(identifier, .failure(NetworkError.invalidResponse)),
            .loadPlaceImages(identifier, .pending),
            .loadPlaceImages(identifier, .loading(nil))
        ]

        actions.forEach { action in
            let previous = next
            next = Reducers.placeImagesReducer(next, action)
            if case let .loadPlaceImages(_, result) = action {
                XCTAssertEqual(next[identifier], result)
            } else {
                XCTAssertEqual(previous, next)
            }
        }
    }
}
