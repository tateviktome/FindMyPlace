//
//  Resolvable.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation

enum Resolvable<T> {
    case pending
    case loading(T?)
    case success(T)
    case failure(Error)
}

extension Resolvable {
    var value: T? {
        switch self {
        case .success(let value): return value
        default: return nil
        }
    }

    var cachedValue: T? {
        switch self {
        case .loading(let value): return value
        default: return nil
        }
    }

    var error: Error? {
        switch self {
        case .failure(let error): return error
        default: return nil
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }

    var isPending: Bool {
        switch self {
        case .pending: return true
        default: return false
        }
    }
}

extension Resolvable: Equatable where T: Equatable {
    static func == (lhs: Resolvable<T>, rhs: Resolvable<T>) -> Bool {
        switch(lhs, rhs) {
        case (.loading, .loading): return true
        case (.pending, .pending): return true
        case (.failure(let error), .failure(let otherError)):
            return error.localizedDescription == otherError.localizedDescription
        case (.success(let value), .success(let otherValue)): return value == otherValue
        default: return false
        }
    }
}
