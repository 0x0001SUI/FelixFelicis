//
//  View+FelicisBinding.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import SwiftUI



public extension View {
    /// Sets the key window environment value of the specified key path to the given state binding.
    ///
    /// To access the current key window state binding use ``FelixFelicis/FelicisBinding`` property wrapper:
    ///
    ///     @FelicisBinding(\.myCustomValue) var value: String?
    ///
    /// - Parameters:
    ///    - keyPath: A key path that indicates the property of the ``FelixFelicis/FelicisValues`` structure to update.
    ///    - binding: The new state binding to set for the item specified by `keyPath`.
    func felicisBinding<Value>(
        _ keyPath: WritableKeyPath<FelicisValues, Binding<Value>?>,
        _ binding: Binding<Value>
    ) -> some View where Value: Equatable {
        modifier(FelicisBindingSetter(keyPath: keyPath, binding: binding))
    }
}


private struct FelicisBindingSetter<T>: ViewModifier, HasLocalState, SetWindow where T: Equatable {

    @ObservedObject var state = LocalEnvironmentState()
    
    var keyPath: WritableKeyPath<FelicisValues, Binding<T>?>
    var binding: Binding<T>
    
    func body(content: Content) -> some View {
        content
            .task(id: binding.wrappedValue, update)
            .window(callback: setWindow)
            .onDisappear {
                GlobalEnvironmentState.shared.values[keyPath: keyPath] = nil
                state.values[keyPath: keyPath] = nil
            }
    }
    
    @Sendable private func update() async {
        state.set(keyPath, binding)
    }
    
}
