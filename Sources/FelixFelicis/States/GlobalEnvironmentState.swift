//
//  GlobalEnvironmentState.swift
//  KeyWindows
//
//  Created by Dima Koskin on 14.11.2022.
//

import SwiftUI


// MARK: - Global Environment State

internal class GlobalEnvironmentState: ObservableObject, FelicisValuesAccess, FelicisObjectsAccess {
    @Published internal var values = FelicisValues()
    @Published internal var objects = FelicisObjects()
    
    internal weak var window: AnyWindow?
    
    internal func `set`(
        window: AnyWindow,
        values: FelicisValues,
        objects: FelicisObjects,
        completion: @escaping () -> Void = {}
    ) {
        DispatchQueue.main.async { [weak self] in
            if self?.window === window {
                self?.values.update(values)
                self?.objects.update(objects)
            } else {
                self?.window = window
                self?.values = values
                self?.objects = objects
            }
            completion()
        }
    }
    
    internal func reset(
        if window: AnyWindow,
        completion: @escaping () -> Void = {}
    ) {
        DispatchQueue.main.async { [weak self] in
            if self?.window === window  {
                self?.window = nil
                self?.values = FelicisValues()
                self?.objects = FelicisObjects()
            }
                                
            completion()
        }
    }
}


// MARK: - Shared
// This is a global object, so use a singleton only.

extension GlobalEnvironmentState {
    internal static let shared: GlobalEnvironmentState = {
        GlobalEnvironmentState()
    }()
}



