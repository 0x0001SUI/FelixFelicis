//
//  File.swift
//  
//
//  Created by Dima Koskin on 17.11.2022.
//

import SwiftUI
@testable import FelixFelicis


// MARK: - Global Environment State Mock

class GlobalEnvironmentStateMock: GlobalEnvironmentState {
    var setWithWindow: AnyWindow?
    var setWithValues: FelicisValues?
    var setWithObjects: FelicisObjects?
    
    override func set(window: AnyWindow, values: FelicisValues, objects: FelicisObjects, completion: @escaping () -> Void = {}) {
        self.setWithWindow = window
        self.setWithValues = values
        self.setWithObjects = objects
        completion()
    }
    
    var resetWithWindow: AnyWindow?
    
    override func reset(if window: AnyWindow, completion: @escaping () -> Void = {}) {
        resetWithWindow = window
        completion()
    }
}

extension GlobalEnvironmentState {
    static let test: GlobalEnvironmentStateMock = {
        GlobalEnvironmentStateMock()
    }()
}


// MARK: - Global State Setter Mock

class GlobalStateSetterMock: GlobalStateSetter {
    var updatedWithWindow: AnyWindow?
    var updatedWithValues: FelicisValues?
    var updatedWithObjects: FelicisObjects?
    
    override func update(window: AnyWindow, values: FelicisValues, objects: FelicisObjects) {
        self.updatedWithWindow = window
        self.updatedWithValues = values
        self.updatedWithObjects = objects
    }
}


// MARK: - AnyWindow Mock

class AnyWindowMock: AnyWindow {
    private var _isMockingKeyWindow: Bool = true

    override var isKeyWindow: Bool {
        _isMockingKeyWindow
    }
    
    func isMockingKeyWindow(_ value: Bool) {
        _isMockingKeyWindow = value
    }
}


// MARK: - Felicis Keys

struct TestFirstKey: FelicisKey {
    typealias Value = Int
}

struct TestSecondKey: FelicisKey {
    typealias Value = Int
}

extension FelicisValues {
    var first: Int? {
        get { self[TestFirstKey.self] }
        set { self[TestFirstKey.self] = newValue }
    }
    
    var second: Int? {
        get { self[TestSecondKey.self] }
        set { self[TestSecondKey.self] = newValue }
    }
}


// MARK: - Felicis Objects

class FirstTestObservaleObject: ObservableObject, Equatable {
    let id: UUID = UUID()
    
    static func == (lhs: FirstTestObservaleObject, rhs: FirstTestObservaleObject) -> Bool {
        ObjectIdentifier(lhs.self) == ObjectIdentifier(rhs.self)
    }
}

class SecondTestObservaleObject: ObservableObject, Equatable {
    let id: UUID = UUID()
    
    static func == (lhs: SecondTestObservaleObject, rhs: SecondTestObservaleObject) -> Bool {
        ObjectIdentifier(lhs.self) == ObjectIdentifier(rhs.self)
    }
}

class ThirdTestObservaleObject: ObservableObject, Equatable {
    let id: UUID = UUID()
    
    static func == (lhs: ThirdTestObservaleObject, rhs: ThirdTestObservaleObject) -> Bool {
        ObjectIdentifier(lhs.self) == ObjectIdentifier(rhs.self)
    }
}
