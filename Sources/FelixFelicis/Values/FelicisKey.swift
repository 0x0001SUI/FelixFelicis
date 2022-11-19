//
//  FelicisKey.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import Foundation


/// A key for accessing values in the key window environment.
///
/// You can create custom key window environment values by extending
/// the ``FelixFelicis/FelicisValues`` structure with new properties.
///
///     private struct MyCustomFelicisKey: FelicisKey {
///         typealias Value = String
///     }
///
/// Then use the key to define a new key window environment value property:
///
///     extension FelicisValues {
///         var myCustomValue: String? {
///             get { self[MyCustomFelicisKey.self] }
///             set { self[MyCustomFelicisKey.self] = newValue }
///         }
///     }
public protocol FelicisKey: Hashable {
    
    /// The associated type representing the type of the key window environment key's value.
    associatedtype Value
}

