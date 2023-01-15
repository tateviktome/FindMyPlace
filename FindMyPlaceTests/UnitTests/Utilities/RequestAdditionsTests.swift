//
//  RequestAdditionsTests.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 11/01/2023.
//

import Foundation
import XCTest
@testable import FindMyPlace

class RequestAdditionsTests: XCTestCase {
    func test_create_url_requests() {
        let methods = [("GET", URLRequest.RequestType.get),
                              ("POST", .post),
                              ("PUT", .put),
                              ("DELETE", .delete),
                              ("PATCH", .patch)]

        for method in methods {
            if let request = generateRequest(method: method.0) {
                URLRequest.create(url: randomURLString, type: method.1)
                    .ephemeralSink { newRequest in
                        XCTAssertEqual(newRequest, request)
                    }
            }
        }

        if let requestWithBody = generateRequest(params: randomParams) {
            URLRequest.create(url: randomURLString, params: randomParams)
                .ephemeralSink { newRequest in
                    XCTAssertEqual(newRequest, requestWithBody)
                }
        }

        if let requestWithQueryParams = requestWithQueryParams {
            URLRequest.create(url: randomURLString, queryItems: randomQueryParams, headers: [:])
                .ephemeralSink { newRequest in
                    XCTAssertEqual(newRequest, requestWithQueryParams)
                }
        }

        if let requestWithHeaders = generateRequest(headers: ["random": "random"]) {
            URLRequest.create(url: randomURLString, headers: ["random": "random"])
                .ephemeralSink { newRequest in
                    XCTAssertEqual(newRequest, requestWithHeaders)
                }
        }
    }
}

extension RequestAdditionsTests {
    var randomParams: [String: Any] {
        ["random": "random"]
    }

    var randomURLString: String {
        "https://google.com"
    }

    var randomQueryParams: [URLQueryItem] {
        [URLQueryItem(name: "random", value: "random")]
    }
    
    func generateRequest(
        method: String = "GET",
        params: [String: Any] = [:],
        headers: [String: String] = URLRequest.RequestType.jsonRequestHeaders
    ) -> URLRequest? {
        guard let url = URL(string: randomURLString) else { return nil }
        var request = URLRequest.init(url: url)
        headers.forEach { request.setValue($0.1, forHTTPHeaderField: $0.0) }
        request.httpMethod = method
        if !params.isEmpty {
            let decoded = try? JSONSerialization.data(withJSONObject: params, options: .init())
            request.httpBody = decoded
        }
        return request
    }

    var requestWithQueryParams: URLRequest? {
        var components = URLComponents(string: randomURLString)
        components?.queryItems = randomQueryParams
        guard let url = components?.url else { return nil }
        return URLRequest(url: url)
    }
}
