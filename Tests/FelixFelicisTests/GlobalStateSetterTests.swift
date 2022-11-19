import XCTest
@testable import FelixFelicis


final class GlobalStateSetterTests: XCTestCase {
    func testSetsKeyWindow() throws {
        let global = GlobalEnvironmentStateMock()
        let setter = GlobalStateSetter(global: global)
        
        let window = AnyWindowMock()
        window.isMockingKeyWindow(true)
        setter.update(window: window, values: FelicisValues(), objects: FelicisObjects())
        
        XCTAssertNotNil(global.setWithWindow)
        XCTAssertNotNil(global.setWithValues)
        XCTAssertNotNil(global.setWithObjects)
    }
    
    func testResetsResignedWindow() throws {
        let global = GlobalEnvironmentStateMock()
        let setter = GlobalStateSetter(global: global)
        
        let window = AnyWindowMock()
        window.isMockingKeyWindow(false)
        setter.update(window: window, values: FelicisValues(), objects: FelicisObjects())
        
        XCTAssertNil(global.setWithWindow)
        XCTAssertNil(global.setWithValues)
        XCTAssertNil(global.setWithObjects)
        
        XCTAssertNotNil(global.resetWithWindow)
    }
}
