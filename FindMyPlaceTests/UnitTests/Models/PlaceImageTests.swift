//
//  PlaceImageTests.swift
//  FindMyPlaceTests
//
//  Created by Tatevik Tovmasyan on 14/01/2023.
//

import Foundation
import XCTest
@testable import FindMyPlace

class PlaceImageTests: XCTestCase {
    func test_generates_image_urls() {
        let images = [(PlaceImage(prefix: "1", suffix: "2"), "1original2"),
                      (PlaceImage(prefix: "", suffix: "2"), "original2"),
                      (PlaceImage(prefix: "1_", suffix: "_2"), "1_original_2")]
        
        for image in images {
            XCTAssertEqual(image.1, image.0.urlString)
        }
    }

    func test_generates_empty_models_if_missing_values() {
        var models = [0, 1].map { _ in PlaceImage(prefix: "", suffix: "") }
        models.append(.init(prefix: "hasPrefix", suffix: "hasSuffix"))
        XCTAssertEqual(models, PlaceImage.fromJSON)
    }
}

extension PlaceImage {
    static var fromJSON: [Self] {
        let bundle = Bundle(for: PlaceImageTests.self)
        guard let fileURL = bundle
                .url(forResource: "PlaceImagesMock", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode([Self].self, from: data)
        } catch {
            return []
        }
    }
}
