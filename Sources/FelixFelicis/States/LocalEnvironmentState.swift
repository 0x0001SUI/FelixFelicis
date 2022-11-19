//
//  LocalEnvironmentState.swift
//  KeyWindows
//
//  Created by Dima Koskin on 14.11.2022.
//

import SwiftUI
import Combine


// MARK: - Local Environment State

internal class LocalEnvironmentState: ObservableObject, FelicisValuesAccess, FelicisObjectsAccess {
    private let setter: GlobalStateSetter
    
    init(setter: GlobalStateSetter = GlobalStateSetter()) {
        self.setter = setter
    }
    
    @Published private var isKeyWindow: Bool = false {
        didSet {
            update()
        }
    }
    
    weak internal var window: AnyWindow? {
        didSet {
            update()
        }
    }
    
    internal var objects = FelicisObjects() {
        didSet {
            update()
        }
    }
    
    internal var values = FelicisValues() {
        didSet {
            update()
        }
    }
    
    /// Sets global state.
    private func update() {
        guard let window = window else {
            return
        }
        
        setter.update(window: window, values: values, objects: objects)
    }
    
    /// Sets a new window and start observing it.
    internal func observeWindow(_ window: AnyWindow?) {
        guard let window = window else {
            return
        }
        
        if self.window !== window {
            self.window = window
            self.isKeyWindow = window.isKeyWindow
        }
        
        guard
            cancellable[window] == nil
        else {
            return // already observing
        }
         
        NotificationCenter.default
            .publisher(for: AnyWindow.didBecomeKeyNotification, object: window)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.isKeyWindow = true
            }
            .store(in: &cancellable[window, default: .init()])

        NotificationCenter.default
            .publisher(for: AnyWindow.didResignKeyNotification, object: window)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.isKeyWindow = false
            }
            .store(in: &cancellable[window, default: .init()])

        #if canImport(AppKit)
        NotificationCenter.default
            .publisher(for: AnyWindow.willCloseNotification, object: window)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.isKeyWindow = false
                self.cancellable.removeValue(forKey: window)
            }
            .store(in: &cancellable[window, default: .init()])
        #endif
    }
    
    private var cancellable = [AnyWindow: Set<AnyCancellable>]()
}

