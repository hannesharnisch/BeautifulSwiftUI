//
//  DialogViewModifier.swift
//
//  Created by Hannes Harnisch on 19.03.21.
//

import Foundation
import SwiftUI


struct DialogViewModifier<Dialog:View>: ViewModifier {
    private var dialog:Dialog
    @Binding private var shown:Bool
    init(isShown: Binding<Bool>,dialog: @escaping () -> Dialog) {
        self.dialog = dialog()
        self._shown = isShown
    }
    func body(content: Content) -> some View {
        ZStack{
            content.disabled(shown).blur(radius: shown ? 3 : 0)
            if shown {
                Color.blue.opacity(0.05).edgesIgnoringSafeArea(.all)
                dialog.background(
                    RoundedRectangle(cornerRadius: 5).foregroundColor(Color.secondary).shadow(color: Color.black, radius: 5)
                ).frame(maxHeight: 500).padding()
            }
        }
    }
}
