//
//  RoundedRectBackgroundModifier.swift
//
//  Created by Hannes Harnisch on 19.03.21.
//

import Foundation
import SwiftUI

struct RoundedRectBackgroundModifier: ViewModifier {
    var color:Color
    func body(content: Content) -> some View {
        content.background(
            RoundedRectangle(cornerRadius: 5).foregroundColor(color)
        )
    }
}
