//
//  ViewExtension.swift
//  
//
//  Created by Hannes Harnisch on 07.06.21.
//

import Foundation
import SwiftUI

public extension View {
    func roundedRectOverlay(color:Color? = nil) -> some View {
        if color != nil {
            return self.modifier(RoundedRectOverlayModifier(color: color!))
        }else{
            return self.modifier(RoundedRectOverlayModifier(color: Color.blue.opacity(0.8)))
        }
    }
    func roundedRectBackground(color:Color? = nil) -> some View {
        if color != nil {
            return self.modifier(RoundedRectBackgroundModifier(color: color!))
        }else{
            return self.modifier(RoundedRectBackgroundModifier(color: Color.blue))
        }
    }
    func dialog<Content:View>(isShown:Binding<Bool>, content:@escaping () -> Content) -> some View {
        return self.modifier(DialogViewModifier(isShown: isShown, dialog: content))
    }
    func buttonBackground(_ color:Color) -> some View {
        return self.environment(\.buttonBackground, color)
    }
    func textFieldBackground(_ color:Color) -> some View {
        return self.environment(\.textFieldBackground, color)
    }
    func loadingIndicator(isShown:Binding<Bool>) -> some View {
        return self.modifier(LoadingModifier(isShown: isShown))
    }
}
