//
//  ui_appTests.swift
//  ui-appTests
//
//  Created by Theodore Webb on 1/8/24.
//

import XCTest
@testable import ui_app

final class ui_appTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


class UserDefaultsManagerTests: XCTestCase {
    func testSaveAndLoad() {
        let manager = UserDefaultsManager()
        let sampleText = "Test String"
        
        manager.save(text: sampleText)
        let loadedText = manager.load()
        
        XCTAssertEqual(loadedText, sampleText, "Loaded text should match the saved text")
    }
}
