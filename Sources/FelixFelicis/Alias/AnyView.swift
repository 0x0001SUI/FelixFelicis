//
//  AnyView.swift
//  
//
//  Created by Dima Koskin on 15.11.2022.
//

import SwiftUI


#if canImport(UIKit)
internal typealias AnyView = UIView
#elseif canImport(AppKit)
internal typealias AnyView = NSView
#else
#error("Unsupported platform")
#endif
