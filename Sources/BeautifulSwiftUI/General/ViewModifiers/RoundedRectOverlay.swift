//
//  RoundedRectOverlay.swift
//
//  Created by Hannes Harnisch on 19.03.21.
//

import Foundation
import SwiftUI


struct RoundedRectOverlayModifier: ViewModifier {
    var color:Color
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 5).stroke(color, lineWidth: 1)
        )
    }
}
