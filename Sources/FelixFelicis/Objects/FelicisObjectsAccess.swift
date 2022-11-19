//
//  FelicisObjectsAccess.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import Foundation
import Combine


internal protocol FelicisObjectsAccess: AnyObject {
    var objects: FelicisObjects { get set }
    
    func get<O>() -> O? where O: ObservableObject
    func set<O>(_ object: O) where O: ObservableObject
    func remove<O>(_ object: O) where O: ObservableObject
}


internal extension FelicisObjectsAccess {
    func get<O>() -> O? where O: ObservableObject {
        objects[O.self]
    }
    
    func set<O>(_ object: O) where O: ObservableObject {
        objects[O.self] = object
    }
    
    func remove<O>(_ object: O) where O: ObservableObject {
        objects[O.self] = nil
    }
}


