//
//  AnyWindow.swift
//  
//
//  Created by Dima Koskin on 15.11.2022.
//

import SwiftUI


#if canImport(UIKit)
internal typealias AnyWindow = UIWindow
#elseif canImport(AppKit)
internal typealias AnyWindow = NSWindow
#else
#error("Unsupported platform")
#endif
