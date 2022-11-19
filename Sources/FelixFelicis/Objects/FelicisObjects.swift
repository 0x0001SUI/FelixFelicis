//
//  FelicisObjects.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import Foundation


internal struct FelicisObjects {
    internal var objects = [AnyFelicisObject: Any]()
    
    internal subscript<O>(_ objectType: O.Type) -> O? where O : ObservableObject {
        get { objects[AnyFelicisObject(objectType)] as! O? }
        set { objects[AnyFelicisObject(objectType)] = newValue }
    }
    
    internal mutating func update(_ other: FelicisObjects) {
        for objectType in other.objects.keys {
            self.objects[objectType] = other.objects[objectType]
        }
    }
    
}

