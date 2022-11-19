//
//  FelicisBinding.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import SwiftUI


// MARK: - Wrapper

/// A property wrapper for accessing and automatically unwrapping state bindings supplied by the key window view.
///
/// Use the `FelicisBinding` property wrapper to read and modify a state value supplied by the key window view. Define access
/// to the state binding using a ``FelixFelicis/FelicisValues`` key path in the property declaration.
///
///     @FelicisBinding(\.myCustomValue) var value: String?
///
///     var body: some View {
///         Button("Clear") {
///             value = ""
///         }
///         .disabled(value == nil)
///     }
///
/// The binding can be supplied by the `felicisBinding(_:_:)`  view modifier.
@propertyWrapper public struct FelicisBinding<Value>: DynamicProperty {
    
    @ObservedObject private var state: GlobalEnvironmentState = .shared
    private let keyPath: WritableKeyPath<FelicisValues, Binding<Value>?>
    
    /// A new property wrapper for the given key path.
    ///
    /// - Parameter keyPath: A key path to a specific resulting value.
    public init(_ keyPath: WritableKeyPath<FelicisValues, Binding<Value>?>) {
        self.keyPath = keyPath
    }
    
    /// The unwrapped value given the current scope and state of the key window view.
    public var wrappedValue: Value? {
        get {
            binding?.wrappedValue
        }
        
        nonmutating set {
            if let newValue = newValue {
                binding?.wrappedValue = newValue
            }
        }
    }
    
    /// A binding to the optional value.
    public var projectedValue: Binding<Value?> {
        Binding {
            wrappedValue
        } set: { newValue in
            if let newValue = newValue {
                binding?.wrappedValue = newValue
            }
        }
    }
    
    private var binding: Binding<Value>? {
        state.get(keyPath)
    }
}
