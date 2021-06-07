//
//  Environment.swift
//  
//
//  Created by Hannes Harnisch on 07.06.21.
//

import Foundation
import SwiftUI

public extension EnvironmentValues {
    var buttonBackground: Color {
        get { self[ButtonBackgroundKey.self] }
        set { self[ButtonBackgroundKey.self] = newValue }
    }
    var textFieldBackground: Color {
        get { self[TextFieldBackgroundKey.self] }
        set { self[TextFieldBackgroundKey.self] = newValue }
    }
    var errorColor: Color {
        get { self[ErrorColorKey.self] }
        set { self[ErrorColorKey.self] = newValue }
    }
}

public struct ButtonBackgroundKey: EnvironmentKey {
    public static let defaultValue = Color.blue
}
public struct TextFieldBackgroundKey: EnvironmentKey {
    public static let defaultValue = Color.blue.opacity(0.02)
}
public struct ErrorColorKey: EnvironmentKey {
    public static let defaultValue = Color.red
}
