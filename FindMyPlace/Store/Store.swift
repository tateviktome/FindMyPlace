//
//  Store.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation
import Combine

protocol Dispatcher {
    var state: AppState { get }
    var services: ServicesProtocol { get }
    func dispatch(_ dispatchable: Dispatchable)
}

final class Store: ObservableObject, Dispatcher {
    @Published private (set) var state: AppState
    let services: ServicesProtocol

    init(
        state: AppState = .init(),
        services: ServicesProtocol = Services()
    ) {
        self.state = state
        self.services = services
    }

    private func dispatchSync(_ dispatchable: Dispatchable) {
        switch dispatchable {
        case let action as Action:
            state = Reducers.root(state, action)
        case let thunkAction as ThunkAction:
            thunkAction.exec(dispatcher: self)
        default: break
        }
    }

    func dispatch(_ dispatchable: Dispatchable) {
        if Thread.isMainThread {
            dispatchSync(dispatchable)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.dispatchSync(dispatchable)
            }
        }
    }
}
