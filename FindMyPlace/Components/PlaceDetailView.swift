//
//  PlaceDetailView.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 14/01/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailView: View, PlaceDetailViewProps {
    @EnvironmentObject var store: Store
    let place: Place

    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text(place.name)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
                .accessibilityLabel("PlaceDetailView_title")
            Text(place.location.formattedAddress)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(images.enumerated()), id: \.offset) {
                        NetworkImage(
                            viewModel: .init(
                                url: $0.element.urlString, store: store
                            ),
                            size: .init(
                                width: UIScreen.main.bounds.height/3,
                                height: UIScreen.main.bounds.height/3
                            )
                        )
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height/3)
            Spacer()
        }
        .onAppear {
            store.dispatch(LoadPlaceImages(id: place.id))
        }
    }
}
