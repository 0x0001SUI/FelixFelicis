import XCTest
@testable import FelixFelicis


final class FelicisObjectsTests: XCTestCase {
    func testGetCorrectObject() throws {
        let first = FirstTestObservaleObject()
        let second = SecondTestObservaleObject()
        let third = ThirdTestObservaleObject()
        
        var objects = FelicisObjects()
        objects[FirstTestObservaleObject.self] = first
        objects[SecondTestObservaleObject.self] = second
        objects[ThirdTestObservaleObject.self] = third
        
        let resultFirst: FirstTestObservaleObject! = objects[FirstTestObservaleObject.self]
        let resultSecond: SecondTestObservaleObject! = objects[SecondTestObservaleObject.self]
        let resultThird: ThirdTestObservaleObject! = objects[ThirdTestObservaleObject.self]
        
        XCTAssertEqual(resultFirst, first)
        XCTAssertEqual(resultSecond, second)
        XCTAssertEqual(resultThird, third)
    }
    
    func testRemoveObject() throws {
        let first = FirstTestObservaleObject()
        var objects = FelicisObjects()
        objects[FirstTestObservaleObject.self] = first
        objects[FirstTestObservaleObject.self] = nil
        
        let result: FirstTestObservaleObject? = objects[FirstTestObservaleObject.self]
        
        XCTAssertNil(result)
    }
    
    func testUpdateObject() throws {
        let first = FirstTestObservaleObject()
        let second = SecondTestObservaleObject()
        
        var objects = FelicisObjects()
        objects[FirstTestObservaleObject.self] = first
        
        var otherObjects = FelicisObjects()
        otherObjects[FirstTestObservaleObject.self] = first
        otherObjects[SecondTestObservaleObject.self] = second
        
        objects.update(otherObjects)
        
        let resultFirst: FirstTestObservaleObject! = objects[FirstTestObservaleObject.self]
        let resultOtherFirst: FirstTestObservaleObject! = otherObjects[FirstTestObservaleObject.self]
        
        let secondFirst: SecondTestObservaleObject! = objects[SecondTestObservaleObject.self]
        let secondOtherFirst: SecondTestObservaleObject! = otherObjects[SecondTestObservaleObject.self]
        
        XCTAssertEqual(resultFirst, resultOtherFirst)
        XCTAssertEqual(secondFirst, secondOtherFirst)
    }
}
