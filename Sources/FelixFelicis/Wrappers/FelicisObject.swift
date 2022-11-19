//
//  FelicisObject.swift
//  
//
//  Created by Dima Koskin on 16.11.2022.
//

import SwiftUI
import Combine


// MARK: - Wrapper


/// A property wrapper type for an observable object supplied by the key window view.
///
/// Use the `FelicisObject` property wrapper to access an observable object supplied by the key window view.
///
///     @FelicisObject var store: Store?
///
///     var body: some View {
///         Button("Update") {
///             store?.update()
///         }
///         .disabled(store == nil)
///     }
///
/// The object can be supplied by the `felicisObject(_:)`  view modifier.
@propertyWrapper public struct FelicisObject<Object>: DynamicProperty where Object : ObservableObject {
    
    @ObservedObject private var state: GlobalEnvironmentState = .shared
    
    /// Creates a key window object.
    public init() {}
    
    /// The underlying value referenced by the key window object.
    public var wrappedValue: Object? {
        self.state.get()
    }

}
