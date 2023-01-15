//
//  FindMyPlaceApp.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import SwiftUI

@main
struct FindMyPlaceApp: App {
    let store = Store()

    var body: some Scene {
        WindowGroup {
            SearchPlacesView()
                .environmentObject(store)
                .preferredColorScheme(.light)
        }
    }
}
