//
//  Reducers.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation

typealias Reducer<T> = (T, Action) -> T

struct Reducers {
    static let root: Reducer<AppState> = { state, action in
        AppState(
            places: placesReducer(state.places, action),
            placeImages: placeImagesReducer(state.placeImages, action)
        )
    }
}

extension Reducers {
    static let placesReducer: Reducer<[PlacesIdentifier: Resolvable<[Place]>]> = { state, action in
        switch action {
        case .loadPlaces(let identifier, let result):
            var copy = state
            copy[identifier] = result
            return copy
        default: return state
        }
    }
}

extension Reducers {
    static let placeImagesReducer: Reducer<[String: Resolvable<[PlaceImage]>]> = { state, action in
        switch action {
        case .loadPlaceImages(let identifier, let result):
            var copy = state
            copy[identifier] = result
            return copy
        default: return state
        }
    }
}
