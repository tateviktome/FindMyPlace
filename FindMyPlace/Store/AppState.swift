//
//  AppState.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation

struct AppState {
    let places: [PlacesIdentifier: Resolvable<[Place]>]
    let placeImages: [String: Resolvable<[PlaceImage]>]

    init(places: [PlacesIdentifier: Resolvable<[Place]>] = [:],
         placeImages: [String: Resolvable<[PlaceImage]>] = [:]) {
        self.places = places
        self.placeImages = placeImages
    }
}
