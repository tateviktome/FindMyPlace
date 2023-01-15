//
//  NetworkImageViewModel.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 11/01/2023.
//

import Foundation
import Combine
import SwiftUI

final class NetworkImageViewModel: ObservableObject {
    let store: Store
    @Published private (set) var image: UIImage?

    init(url: String?, store: Store) {
        self.store = store
        guard let url = url else {
            return
        }

        store.services.imageService.loadImage(with: url)
            .map {
                switch $0 {
                case .success(let image): return image
                default: return UIImage(named: "no_connection")
                }
            }
            .assign(to: &$image)
    }
}
