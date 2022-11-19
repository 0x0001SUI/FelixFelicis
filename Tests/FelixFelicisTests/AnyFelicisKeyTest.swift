import XCTest
@testable import FelixFelicis


final class AnyFelicisKeyTest: XCTestCase {
    func testEquatability() {
        let firstAnyKey = AnyFelicisKey(TestFirstKey.self)
        let secondAnyKey = AnyFelicisKey(TestSecondKey.self)
        
        XCTAssertNotEqual(firstAnyKey, secondAnyKey)
    }
}
