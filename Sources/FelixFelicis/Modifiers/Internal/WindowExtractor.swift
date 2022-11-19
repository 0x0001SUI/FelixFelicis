//
//  WindowExtractor.swift
//  KeyWindows
//
//  Created by Dima Koskin on 14.11.2022.
//

import SwiftUI



internal struct WindowExtractor: AnyRepresentable {    
    var callback: (AnyWindow?) -> Void
    
    func makeUIView(context: Context) -> AnyView {
        makeRepresentableView()
    }
    
    func makeNSView(context: Context) -> AnyView {
        makeRepresentableView()
    }
    
    func updateUIView(_ view: AnyView, context: Context) {
        updateView(view)
    }
    
    func updateNSView(_ view: AnyView, context: Context) {
        updateView(view)
    }
    
    private func makeRepresentableView() -> AnyView {
        let view = AnyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    private func updateView(_ view: AnyView) {
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
    }
}


internal extension View {
    /// Retrieves the window object from the view.
    func window(callback: @escaping (AnyWindow?) -> Void) -> some View {
        self.background {
            WindowExtractor(callback: callback)
        }
    }
}
