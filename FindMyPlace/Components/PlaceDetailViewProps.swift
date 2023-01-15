//
//  PlaceDetailViewProps.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 14/01/2023.
//

import Foundation

protocol PlaceDetailViewProps {
    var store: Store { get }
    var place: Place { get }
}

extension PlaceDetailViewProps {
    var images: [PlaceImage] {
        store.state.placeImages[place.id]?.value ?? []
    }
}
