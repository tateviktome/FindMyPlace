//
//  PublisherAdditions.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation
import Combine

extension Publisher {
    func ephemeralSink(_ receivedValue: @escaping (Output) -> Void) {
        subscribe(Subscribers.Sink(receiveCompletion: { _ in }, receiveValue: receivedValue))
    }

    func asResolvable() -> AnyPublisher<Resolvable<Output>, Never> {
        map { Resolvable.success($0) }
        .catch { Just(Resolvable.failure($0)) }
        .eraseToAnyPublisher()
    }
}
