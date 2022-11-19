import XCTest
@testable import FelixFelicis


final class GlobalEnvironmentStateTests: XCTestCase {
    func testSetState() throws {
        let window = AnyWindow()
        let state = GlobalEnvironmentState()
        
        var objects = FelicisObjects()
        objects[FirstTestObservaleObject.self] = FirstTestObservaleObject()
        objects[SecondTestObservaleObject.self] = SecondTestObservaleObject()
        var values = FelicisValues()
        values[keyPath: \.first] = 1
        values[keyPath: \.second] = 2
                

        let expectation = XCTestExpectation(description: "Wait for setting up")
        
        state.set(window: window, values: values, objects: objects) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(state.get(\.first), 1)
        XCTAssertEqual(state.get(\.second), 2)
        
        let resultFirst: FirstTestObservaleObject? = state.get()
        let resultSecond: SecondTestObservaleObject? = state.get()
        
        XCTAssertNotNil(resultFirst)
        XCTAssertNotNil(resultSecond)
    }
    
    func testResetState() throws {
        let window = AnyWindow()
        let state = GlobalEnvironmentState()
        
        var objects = FelicisObjects()
        objects[FirstTestObservaleObject.self] = FirstTestObservaleObject()
        objects[SecondTestObservaleObject.self] = SecondTestObservaleObject()
        
        var values = FelicisValues()
        values[keyPath: \.first] = 1
        values[keyPath: \.second] = 2
                        
        let expectation = XCTestExpectation(description: "Wait for setting up and resetting")
        
        state.set(window: window, values: values, objects: objects) {
            state.reset(if: window) {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNil(state.get(\.first))
        XCTAssertNil(state.get(\.second))
        
        let resultFirst: FirstTestObservaleObject? = state.get()
        let resultSecond: SecondTestObservaleObject? = state.get()
        
        XCTAssertNil(resultFirst)
        XCTAssertNil(resultSecond)
    }
}
