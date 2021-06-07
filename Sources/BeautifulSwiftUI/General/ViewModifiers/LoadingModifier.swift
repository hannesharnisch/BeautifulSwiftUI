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
                Color.blue.opacity(0.05).edgesIgnoringSafeArea(.all)
                DefaultAcitivtyIndicator().background(
                    RoundedRectangle(cornerRadius: 5).foregroundColor(Color.secondary).shadow(color: Color.black, radius: 5)
                ).frame(maxHeight: 500).padding()
            }
        }
    }
}
