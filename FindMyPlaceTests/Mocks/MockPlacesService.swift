//
//  MockPlacesService.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 13/01/2023.
//

import Foundation
import Combine
@testable import FindMyPlace

final class MockPlacesService: PlacesServiceProtocol {
    var fetchPlacesStub: ((PlacesIdentifier) -> AnyPublisher<[Place], Error>)?
    var fetchPlaceImagesStub: ((String) -> AnyPublisher<[PlaceImage], Error>)?

    func loadPlaces(with identifier: PlacesIdentifier) -> AnyPublisher<[Place], Error> {
        guard let stub = fetchPlacesStub else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        return stub(identifier)
    }

    func loadPlaceImages(with id: String) -> AnyPublisher<[PlaceImage], Error> {
        guard let stub = fetchPlaceImagesStub else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        return stub(id)
    }
}
