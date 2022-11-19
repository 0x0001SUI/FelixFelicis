//
//  AnyFelicisObject.swift
//  
//
//  Created by Dima Koskin on 18.11.2022.
//

import SwiftUI



internal struct AnyFelicisObject {
    internal let objectType: Any.Type

    internal init<O>(_ objectType: O.Type) where O: ObservableObject {
        self.objectType = objectType
    }
}


extension AnyFelicisObject: Hashable {
    static func == (lhs: AnyFelicisObject, rhs: AnyFelicisObject) -> Bool {
        return ObjectIdentifier(lhs.objectType) == ObjectIdentifier(rhs.objectType)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self.objectType))
    }
}
