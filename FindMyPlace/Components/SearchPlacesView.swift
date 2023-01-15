//
//  SearchPlacesView.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import SwiftUI

struct SearchPlacesView: View, SearchPlacesViewProps {
    @EnvironmentObject var store: Store
    @State var query: String = "coffee"
    @State var radius: String = "10"
    
    var body: some View {
        content
        .onChange(of: placesIdentifier) { newValue in
            guard let newValue = newValue else { return }
            store.dispatch(LoadPlaces(identifier: newValue))
        }
        .onAppear {
            guard let placesIdentifier = placesIdentifier else { return }
            store.dispatch(LoadPlaces(identifier: placesIdentifier))
        }
    }

    private var content: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    TextField("type", text: $query)
                        .textFieldStyle(RoundedTextFieldStyle())
                        .autocorrectionDisabled()
                    TextField("radius", text: $radius)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedTextFieldStyle())
                }
                if let error = error {
                    errorView(error: error)
                } else if let places = places {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            Spacer()
                                .frame(height: 12)
                            ForEach(Array(places.enumerated()), id: \.offset) { place in
                                NavigationLink(destination: {
                                    PlaceDetailView(place: place.element)
                                }, label: {
                                    PlaceView(place: place.element)
                                })
                            }
                        }
                    }
                    .transition(AnyTransition.opacity.animation(Animation.easeIn(duration: 0.1)))
                    .accessibilityIdentifier("SearchPlacesView_places_list")
                } else if isLoading {
                    SkeletonView()
                } else {
                    Spacer()
                }
            }
            .padding([.top, .horizontal], 10)
            .navigationTitle("Where to?")
        }
    }

    private func errorView(error: UIError) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                Text(error.description)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                Image(error.imageName)
                    .resizable()
                    .frame(
                        width: UIScreen.main.bounds.width - 200,
                        height: UIScreen.main.bounds.width - 200
                    )
            }
            .padding(.top, 20)
        }
    }
}

struct SkeletonView: View {
    let places = [Place(id: "1", name: "default", location: .init(formattedAddress: "the longest location in the planet"))]
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Spacer()
                    .frame(height: 12)
                ForEach(Array(places.enumerated()), id: \.offset) {
                    PlaceView(place: $0.element)
                }
            }
        }
        .redacted(reason: .placeholder)
        .transition(AnyTransition.opacity.animation(Animation.easeIn(duration: 0.1)))
    }
}
