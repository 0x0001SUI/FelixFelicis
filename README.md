# Felix  🪄 Felicis

The package adds a new global environment to your SwiftUI app, that contains only values from the **key window**.


The package comes in handy when the application supports multiple windows, and you, for example, need to open a sheet from commands only in the active window.

## Getting Started

The interface is similar to the [`EnvironmentValues`](https://developer.apple.com/documentation/swiftui/environmentvalues).

```swift
import SwiftUI
import FelixFelicis
```

First, you need to define a custom key using `FelicisKey` protocol:

```swift
private struct FavoriteBindingFelicisKey: FelicisKey {
    typealias Value = Binding<Bool>
}
```

And extend `FelicisValues` structure with a new property:

```swift
extension FelicisValues {
    var isFavorite: FavoriteBindingFelicisKey.Value? {
        get { self[FavoriteBindingFelicisKey.self] }
        set { self[FavoriteBindingFelicisKey.self] = newValue }
    }
}
```

Now you can set the value inside a view:

```swift
struct MyView: View {
    @State private var isFavorite = false

    var body: some View {
        Group {
            if isFavorite {
                Text("Favorite")
            }
        }
        .felicisBinding(\.isFavorite, $isFavorite)
    }
}
```

And access that value in *any* part of your app:

```swift
struct FavoriteCommands: Commands {
    @FelicisBinding(\.isFavorite) private var isFavorite: Bool?

    var body: some Commands {
        CommandGroup(after: .toolbar) {
            if let isFavorite = isFavorite {
                Button {
                    isFavorite.toggle()
                } label: {
                    if isFavorite {
                        Text("Unfavorite")
                    } else {
                        Text("Favorite")
                    }
                }
            }
        }
    }
}
```

The value you get will only be from the **key window**.

## Overview

The package provides you with three property wrappers:

- **`@FelicisValue`** — to get a key window value
- **`@FelicisBinding`** — to get a key window state binding
- **`@FelicisObject`** — to get a key window observable object

And three view modifiers, respectively:

- **`felicisValue(_:_:)`** — to add a value to the environment
- **`felicisBinding(_:_:)`** — to add a binding to the environment
- **`felicisObject(_:)`** — to add an observable object to the environment

The package is well documented, so if you have any additional questions, you can build documentation in Xcode.
