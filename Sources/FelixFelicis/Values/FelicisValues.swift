//
//  FelicisValues.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import Foundation


/// A collection of key window environment values.
///
/// Create custom key window environment values by defining a type that conforms to the ``FelixFelicis/FelicisKey`` protocol,
/// and then extending this structure with a new property.
///
///     private struct MyFelicisKey: FelicisKey {
///         typealias Value = String
///     }
///
///     extension FelicisValues {
///         var myCustomValue: String? {
///             get { self[MyFelicisKey.self] }
///             set { self[MyFelicisKey.self] = newValue }
///         }
///     }
///
/// To set the key window environment value use the provided view modifiers:
///
///     MyView()
///         .felicisValue(\.myCustomValue, "another string")
///
/// To read the value use one of the provided property wrappers:
///
///     @FelicisValue(\.myCustomValue) var value: String?
///
public struct FelicisValues {
    
    internal var values = [AnyFelicisKey: Any]()
    
    /// Accesses the key window environment value associated with a custom key.
    ///
    /// Create custom key window environment values by defining a key
    /// that conforms to the ``FelixFelicis/FelicisKey`` protocol, and then using that
    /// key with the subscript operator of the ``FelicisValues`` structure
    /// to get and set a value for that key:
    ///
    ///     private struct MyFelicisKey: FelicisKey {
    ///         typealias Value = String
    ///     }
    ///
    ///     extension CurrentValues {
    ///         var myCustomValue: String? {
    ///             get { self[MyFelicisKey.self] }
    ///             set { self[MyFelicisKey.self] = newValue }
    ///         }
    ///     }
    public subscript<Key>(_ key: Key.Type) -> Key.Value? where Key : FelicisKey {
        get { values[AnyFelicisKey(key)] as! Key.Value? }
        set { values[AnyFelicisKey(key)] = newValue }
    }
        
    internal mutating func update(_ other: Self) {
        for key in other.values.keys {
            self.values[key] = other.values[key]
        }
    }
}

