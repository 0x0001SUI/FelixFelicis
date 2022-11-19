//
//  FelicisValuesAccess.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import Foundation


internal protocol FelicisValuesAccess: AnyObject {
    var values: FelicisValues { get set }
    
    func set<Value>(_ keyPath: WritableKeyPath<FelicisValues, Value>, _ value: Value)
    func get<Value>(_ keyPath: KeyPath<FelicisValues, Value>) -> Value
}


internal extension FelicisValuesAccess {
    func set<Value>(_ keyPath: WritableKeyPath<FelicisValues, Value>, _ value: Value) {
        self.values[keyPath: keyPath] = value
    }
    
    func get<Value>(_ keyPath: KeyPath<FelicisValues, Value>) -> Value {
        self.values[keyPath: keyPath]
    }
}
