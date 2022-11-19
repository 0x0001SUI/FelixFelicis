//
//  View+FelicisValue.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import SwiftUI


public extension View {
    /// Sets the key window environment value of the specified key path to the given value.
    ///
    /// To read the current key window value use ``FelixFelicis/FelicisValue`` property wrapper:
    ///
    ///     @FelicisValue(\.myCustomValue) var value: String?
    ///
    /// - Parameters:
    ///    - keyPath: A key path that indicates the property of the ``FelixFelicis/FelicisValues`` structure to update.
    ///    - value: The new value to set for the item specified by `keyPath`.
    func felicisValue<Value>(
        _ keyPath: WritableKeyPath<FelicisValues, Value?>,
        _ value: Value
    ) -> some View where Value: Equatable {
        modifier(FelicisValueSetter(keyPath: keyPath, value: value))
    }
}


private struct FelicisValueSetter<T>: ViewModifier, HasLocalState, SetWindow where T: Equatable {
    
    @ObservedObject var state = LocalEnvironmentState()

    var keyPath: WritableKeyPath<FelicisValues, T?>
    var value: T
    
    func body(content: Content) -> some View {
        content
            .task(id: value, update)
            .window(callback: setWindow)
            .onDisappear {
                GlobalEnvironmentState.shared.values[keyPath: keyPath] = nil
                state.values[keyPath: keyPath] = nil
            }
    }
    
    @Sendable private func update() async {
        state.set(keyPath, value)
    }
}
