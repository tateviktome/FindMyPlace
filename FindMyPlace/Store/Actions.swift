//
//  Actions.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation

protocol Dispatchable {}

protocol ThunkAction: Dispatchable {
    func exec(dispatcher: Dispatcher)
}

enum Action: Dispatchable {
    case loadPlaces(PlacesIdentifier, Resolvable<[Place]>)
    case loadPlaceImages(String, Resolvable<[PlaceImage]>)
}

struct LoadPlaces: ThunkAction {
    let identifier: PlacesIdentifier

    func exec(dispatcher: Dispatcher) {
        let value = dispatcher.state.places[identifier]?.value
        dispatcher.dispatch(Action.loadPlaces(identifier, .loading(value)))

        dispatcher.services
            .placesService
            .loadPlaces(with: identifier)
            .asResolvable()
            .ephemeralSink { places in
                dispatcher.dispatch(Action.loadPlaces(identifier, places))
            }
    }
}

struct LoadPlaceImages: ThunkAction {
    let id: String

    func exec(dispatcher: Dispatcher) {
        dispatcher.dispatch(Action.loadPlaceImages(id, .loading(nil)))

        dispatcher.services
            .placesService
            .loadPlaceImages(with: id)
            .asResolvable()
            .ephemeralSink { images in
                dispatcher.dispatch(Action.loadPlaceImages(id, images))
            }
    }
}
