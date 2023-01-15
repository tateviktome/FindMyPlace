//
//  SearchPlacesViewProps.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation

protocol SearchPlacesViewProps {
    var store: Store { get }
    var query: String { get set }
    var radius: String { get set }
}

extension SearchPlacesViewProps {
    var isLoading: Bool {
        guard let placesIdentifier = placesIdentifier else { return false }
        return store.state.places[placesIdentifier]?.isLoading == true
    }

    var places: [Place]? {
        guard let placesIdentifier = placesIdentifier else { return nil }
        let placesResolvable = store.state.places[placesIdentifier]
        return placesResolvable?.value ?? placesResolvable?.cachedValue
    }

    var placesIdentifier: PlacesIdentifier? {
        guard let radius = Int(radius) else { return nil }
        return .init(type: query, radius: radius)
    }

    var error: UIError? {
        guard let placesIdentifier = placesIdentifier else { return nil }
        if let error = store.state.places[placesIdentifier]?.error as? NetworkError {
            switch error {
            case .decoding:
                return .decoding
            case let .invalidRequest(description):
                return .invalidRequest(description)
            default:
                return .noConnection
            }
        }

        if !isLoading, places?.isEmpty == true {
            return .noResult(placesIdentifier)
        }

        return nil
    }
}
