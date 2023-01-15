//
//  NetworkService.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetch<T>(
        _ request: URLRequest,
        decoding _: T.Type,
        with decoder: JSONDecoder
    ) -> AnyPublisher<T, Error> where T : Decodable
}

enum NetworkError: Error {
    case decoding
    case invalidRequest(description: String)
    case invalidResponse
}

final class NetworkService: NetworkServiceProtocol {
    let session = URLSession.shared

    func fetch<T>(
        _ request: URLRequest,
        decoding _: T.Type,
        with decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> where T : Decodable {
        session.dataTaskPublisher(for: request)
            .tryMap {
                do {
                    let decoded = try decoder.decode(T.self, from: $0.0)
                    return decoded
                } catch {
                    if let jsonObject = try? JSONSerialization.jsonObject(with: $0.0) as? [String: Any],
                       let value = jsonObject["message"] as? String {
                        throw NetworkError.invalidRequest(description: value)
                    }
                    throw NetworkError.decoding
                }
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }
}
