//
//  MockServices.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 13/01/2023.
//

import Foundation
@testable import FindMyPlace

class MockServices {
    var mockPlacesService: MockPlacesService

    init() {
        self.mockPlacesService = MockPlacesService()
    }
}

extension MockServices: ServicesProtocol {
    var networkService: NetworkServiceProtocol { NetworkService() }
    var placesService: PlacesServiceProtocol { mockPlacesService }
    var imageService: ImageServiceProtocol { ImageService() }
}
