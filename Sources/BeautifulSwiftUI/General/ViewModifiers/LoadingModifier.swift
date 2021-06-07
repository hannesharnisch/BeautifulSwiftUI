//
//  LoadingModifier.swift
//  
//
//  Created by Hannes Harnisch on 07.06.21.
//

import Foundation
import SwiftUI

struct LoadingModifier: ViewModifier{
    @Binding private var shown:Bool
    init(isShown: Binding<Bool>) {
        self._shown = isShown
    }
    func body(content: Content) -> some View {
        ZStack{
            content.disabled(shown).opacity(shown ? 0.6 : 1)
            if shown {
                DefaultAcitivtyIndicator().defaultBackground().frame(maxWidth:150, maxHeight: 150, alignment: .center).padding()
            }
        }
    }
}
