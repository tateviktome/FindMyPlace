//
//  NetworkImage.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 11/01/2023.
//

import Foundation
import SwiftUI

struct NetworkImage: View {
    @ObservedObject var viewModel: NetworkImageViewModel
    var size: CGSize = .zero

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .transition(.opacity.animation(.easeIn(duration: 0.3)))
                    .frame(width: size.width, height: size.width, alignment: .center)
            }
        }
            .frame(width: size.width, height: size.height, alignment: .center)
            .clipped()
    }
}
