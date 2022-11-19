import XCTest
@testable import FelixFelicis


final class LocalEnvironmentStateTests: XCTestCase {
    func testUpdatesGlobalStateOnChange() throws {
        let window = AnyWindowMock()
        window.isMockingKeyWindow(true)
        
        let setter = GlobalStateSetterMock(global: .test)
        let state = LocalEnvironmentState(setter: setter)
        
        state.observeWindow(window)
        state.set(\.first, 1)
        state.set(FirstTestObservaleObject())
        
        XCTAssertEqual(setter.updatedWithWindow, window)
        
        if let objects = setter.updatedWithObjects {
            let firstObject: FirstTestObservaleObject? = objects[FirstTestObservaleObject.self]
            XCTAssertNotNil(firstObject)
        } else {
            XCTAssert(false, "No objects was setted")
        }
        
        if let values = setter.updatedWithValues {
            XCTAssertEqual(values[keyPath: \.first], 1)
        } else {
            XCTAssert(false, "No values was setted")
        }
    }
}
