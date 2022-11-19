//
//  View+FelicisObject.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import SwiftUI


public extension View {
    /// Supplies an `ObservableObject` to the key window environment.
    ///
    /// The object can be accessed by using ``FelixFelicis/FelicisObject``.

    /// - Parameter object: the object to store.
    func felicisObject<Object>(
        _ object: Object
    ) -> some View where Object : ObservableObject {
        modifier(FelicisObjectSetter(object: object))
    }
}


private struct FelicisObjectSetter<T>: ViewModifier, HasLocalState, SetWindow where T: ObservableObject {
    
    @ObservedObject var state = LocalEnvironmentState()

    var object: T

    func body(content: Content) -> some View {
        content
            .task(id: ObjectIdentifier(object), update)
            .window(callback: setWindow)
            .onDisappear {
                GlobalEnvironmentState.shared.remove(object)
                state.remove(object)
            }
    }
    
    @Sendable private func update() async {
        state.set(object)
    }
}

