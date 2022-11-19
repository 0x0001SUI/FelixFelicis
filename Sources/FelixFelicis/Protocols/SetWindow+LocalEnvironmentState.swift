//
//  File.swift
//  
//
//  Created by Dima Koskin on 17.11.2022.
//

import Foundation


internal extension SetWindow where Self : HasLocalState {
    func setWindow(_ window: AnyWindow?) {
        state.observeWindow(window)
    }
}
