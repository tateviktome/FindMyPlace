//
//  Services.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation

protocol ServicesProtocol {
    var networkService: NetworkServiceProtocol { get }
    var placesService: PlacesServiceProtocol { get }
    var imageService: ImageServiceProtocol { get }
}

struct Services: ServicesProtocol {
    let networkService: NetworkServiceProtocol
    let placesService: PlacesServiceProtocol
    let imageService: ImageServiceProtocol

    init() {
        networkService = NetworkService()
        placesService = PlacesService(networkService: networkService)
        imageService = ImageService()
    }
}
