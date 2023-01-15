//
//  RequestAdditions.swift
//  FindMyPlace
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import Foundation
import Combine

extension URLRequest {
    init?(
        url: String,
        queryItems: [URLQueryItem] = [],
        type: RequestType = .get,
        params: Any? = nil,
        headers: [String: String] = RequestType.jsonRequestHeaders
    ) {
        var components = URLComponents(string: url)
        let items = [components?.queryItems, queryItems].compactMap { $0 }.flatMap { $0 }
        if !items.isEmpty {
            components?.queryItems = items
        }
        guard let resultURL = components?.url else { return nil }
        self.init(url: resultURL)
        httpMethod = type.rawValue.uppercased()
        headers.forEach { self.setValue($0.1, forHTTPHeaderField: $0.0) }

        if let params = params, let data = try? JSONSerialization.data(withJSONObject: params, options: .init()) {
            httpBody = data
        }
    }
    
    static func create(
        url: String,
        queryItems: [URLQueryItem] = [],
        type: RequestType = .get,
        params: Any? = nil,
        headers: [String: String] = RequestType.jsonRequestHeaders
    ) -> AnyPublisher<URLRequest, Error> {
        Future<URLRequest, Error> { promise in
            guard
                let request = URLRequest(
                    url: url,
                    queryItems: queryItems,
                    type: type,
                    params: params,
                    headers: headers
                )
            else {
                promise(.failure(NetworkError.invalidRequest(description: "Something went wrong")))
                return
            }
            promise(.success(request))
        }
        .share()
        .eraseToAnyPublisher()
    }
}

extension URLRequest {
    enum RequestType: String {
        case get, post, put, patch, delete

        static var jsonRequestHeaders = [
            "Accept": "application/json",
            "Authorization": "fsq3tTZXx9lKNfs5NWAtFKJ7lRN+5reTqwxaC+1lLukVXvc="
        ]
    }
}
