//
//  FindMyPlaceUITests.swift
//  FindMyPlaceUITests
//
//  Created by Tatevik Tovmasyan on 10/01/2023.
//

import XCTest

final class FindMyPlaceUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    func test_shows_some_result() throws {
        app.textFields["radius"].tap()
        app.textFields["radius"].typeText("000")
        XCTAssert(app.scrollViews["SearchPlacesView_places_list"].waitForExistence(timeout: 6))
    }

    func test_shows_no_result() throws {
        app.textFields["type"].tap()
        app.textFields["type"].typeText("coffeeaaaaaaaaaaaabbbbbbbbcccccccccc")
        XCTAssert(app.scrollViews.otherElements.images["no_result"].waitForExistence(timeout: 6))
    }

    func test_shows_invalid_request_error() throws {
        app.textFields["radius"].tap()
        app.textFields["radius"].typeText("10000000000")
        XCTAssert(app.scrollViews.otherElements.images["decoding_error"].waitForExistence(timeout: 6))
    }

    func test_loads_details_page() throws {
        app.textFields["radius"].tap()
        app.textFields["radius"].typeText("000")
        sleep(6)
        app.scrollViews["SearchPlacesView_places_list"].buttons.firstMatch.tap()
        XCTAssert(app.staticTexts["PlaceDetailView_title"].waitForExistence(timeout: 2))
    }
}
