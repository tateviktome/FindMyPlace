//
//  UIError.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 14/01/2023.
//

import Foundation

enum UIError {
    case invalidRequest(String)
    case noConnection
    case noResult(PlacesIdentifier)
    case decoding

    var description: String {
        switch self {
        case .noConnection:
            return "Oops... Seems like we have connection errors"
        case .noResult(let identifier):
            return "We couldn't find anything for \(identifier.type) within the radius of \(identifier.radius)"
        case .decoding:
            return "Oops.. We face technical issues. Pls try later."
        case .invalidRequest(let string):
            return string
        }
    }

    var imageName: String {
        switch self {
        case .noConnection:
            return "no_connection"
        case .noResult:
            return "no_result"
        case .decoding, .invalidRequest:
            return "decoding_error"
        }
    }
}
