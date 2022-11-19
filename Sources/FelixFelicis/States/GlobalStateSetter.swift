//
//  GlobalStateSetter.swift
//  
//
//  Created by Dima Koskin on 17.11.2022.
//

import Foundation


// MARK: - Global State Setter

internal class GlobalStateSetter {
    private let state: GlobalEnvironmentState
    
    init(global: GlobalEnvironmentState = .shared) {
        self.state = global
    }
    
    func update(window: AnyWindow, values: FelicisValues, objects: FelicisObjects) {
        if window.isKeyWindow {
            // update global state with values and objects for the current window
            state.set(window: window, values: values, objects: objects)
        } else {
            // requesst reset values and object for the specific window
            state.reset(if: window)
        }
    }
}
