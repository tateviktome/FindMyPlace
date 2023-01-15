//
//  PlaceView.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 13/01/2023.
//

import Foundation
import SwiftUI

struct PlaceView: View {
    @EnvironmentObject var store: Store
    let place: Place

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(place.name)
                        .font(Font.system(size: 18))
                        .multilineTextAlignment(.leading)
                    Text(place.location.formattedAddress)
                        .font(Font.system(size: 14))
                        .foregroundColor(Color(UIColor.systemGray))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
            }
            .padding(20)
        }
        .frame(height: 80)
        .padding(.horizontal, 8)
        .clipShape(Rectangle())
        .shadow(color: Color(UIColor.systemGray5), radius: 4, x: 2, y: 2)
    }
}
