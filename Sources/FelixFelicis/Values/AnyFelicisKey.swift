//
//  AnyFelicisKey.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import Foundation


internal struct AnyFelicisKey {
    internal let keyType: Any.Type

    internal init<K>(_ keyType: K.Type) where K: FelicisKey {
        self.keyType = keyType
    }
}


extension AnyFelicisKey: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return ObjectIdentifier(lhs.keyType) == ObjectIdentifier(rhs.keyType)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self.keyType))
    }
}
