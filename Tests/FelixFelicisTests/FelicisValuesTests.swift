import XCTest
@testable import FelixFelicis


final class FelicisValuesTests: XCTestCase {
    func testGetCorrectValue() throws {
        var values = FelicisValues()
        values[keyPath: \.first] = 1
        values[keyPath: \.second] = 2
        
        XCTAssertEqual(values[keyPath: \.first], 1)
        XCTAssertEqual(values[keyPath: \.second], 2)
    }
    
    func testUpdateValue() throws {
        var values = FelicisValues()
        values[keyPath: \.first] = 1
        
        XCTAssertEqual(values[keyPath: \.first], 1)
        
        var otherValues = FelicisValues()
        otherValues[keyPath: \.first] = 3
        otherValues[keyPath: \.second] = 4
        
        values.update(otherValues)
        
        XCTAssertEqual(values[keyPath: \.first], 3)
        XCTAssertEqual(values[keyPath: \.second], 4)
    }
}
