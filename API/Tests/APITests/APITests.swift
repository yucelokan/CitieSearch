import XCTest
@testable import API

final class APITests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(API().text, "Hello, World!")
    }
}
