//
//  PlacesService.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation
import Combine

protocol PlacesServiceProtocol {
    func loadPlaces(with identifier: PlacesIdentifier) -> AnyPublisher<[Place], Error>
    func loadPlaceImages(with id: String) -> AnyPublisher<[PlaceImage], Error>
}

struct PlacesService: PlacesServiceProtocol {
    let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func loadPlaces(with identifier: PlacesIdentifier) -> AnyPublisher<[Place], Error> {
        return URLRequest
            .create(url: "https://api.foursquare.com/v3/places/search?query=\(identifier.type)&radius=\(identifier.radius)")
            .flatMap { networkService.fetch($0, decoding: PlacesResult.self, with: .init()) }
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func loadPlaceImages(with id: String) -> AnyPublisher<[PlaceImage], Error> {
        return URLRequest
            .create(url: "https://api.foursquare.com/v3/places/\(id)/photos")
            .flatMap { networkService.fetch($0, decoding: [PlaceImage].self, with: .init()) }
            .eraseToAnyPublisher()
    }
}
