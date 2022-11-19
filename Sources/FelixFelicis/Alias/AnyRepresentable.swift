//
//  AnyRepresentable.swift
//  
//
//  Created by Dima Koskin on 15.11.2022.
//

import SwiftUI


#if canImport(UIKit)
internal typealias AnyRepresentable = UIViewRepresentable
#elseif canImport(AppKit)
internal typealias AnyRepresentable = NSViewRepresentable
#else
#error("Unsupported platform")
#endif
