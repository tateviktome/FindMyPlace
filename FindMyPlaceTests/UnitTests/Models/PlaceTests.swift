//
//  PlaceTests.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 16/01/2023.
//

import Foundation
import XCTest
@testable import FindMyPlace

class PlaceTests: XCTestCase {
    func test_generates_empty_models_if_missing_values() {
        var models = [0, 1, 2].map { _ in Place(id: "", name: "", location: .init(formattedAddress: "")) }
        models.append(.init(id: "hasId", name: "hasName", location: .init(formattedAddress: "hasFormattedAddress")))
        XCTAssertEqual(models, PlacesResult.fromJSON?.results)
    }
}

extension PlacesResult {
    static var fromJSON: Self? {
        let bundle = Bundle(for: PlaceTests.self)
        guard let fileURL = bundle
                .url(forResource: "PlacesResultMock", withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode(PlacesResult.self, from: data)
        } catch {
            return nil
        }
    }
}
