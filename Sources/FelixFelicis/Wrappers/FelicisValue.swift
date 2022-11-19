//
//  File.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import SwiftUI


// MARK: - Wrapper


/// A property wrapper for accessing values supplied by the key window view.
///
/// Use the `FelicisValue` property wrapper to read a value stored in a key window environment. Indicate the
/// value to read using a ``FelixFelicis/FelicisValues`` key path in the property declaration.
///
///     @FelicisValue(\.myString) var myString: String?
///
///     var body: some View {
///         if let myString = myString {
///             MyStringContent(myString)
///         } else {
///             PlaceholderContent()
///         }
///     }
///
/// The value can be supplied by the `felicisValue(_:_:)`  view modifier.
@propertyWrapper public struct FelicisValue<Value>: DynamicProperty {
    
    @ObservedObject private var state: GlobalEnvironmentState = .shared
    private let keyPath: KeyPath<FelicisValues, Value>
    
    /// Creates a key window environment property to read the specified key path
    ///
    /// - Parameter keyPath: A key path to a specific resulting value.
    public init(_ keyPath: KeyPath<FelicisValues, Value>) {
        self.keyPath = keyPath
    }
        
    /// The current value of the key window environment property.
    public var wrappedValue: Value {
        state.get(keyPath)
    }
}
