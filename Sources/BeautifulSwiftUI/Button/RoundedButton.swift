//
//  RoundedButton.swift
//  
//
//  Created by Hannes Harnisch on 07.06.21.
//

import SwiftUI

public struct RoundedButton<Content: View>: View{
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.buttonBackground) var backgroundColor
    private var action:()->()
    private var content:Content
    public init(action: @escaping () -> (), label:@escaping () -> Content){
        self.action = action
        self.content = label()
    }
    public var body: some View {
        Button(action: action, label: {
            content.padding().roundedRectBackground(color: self.isEnabled ? backgroundColor : backgroundColor.opacity(0.8))
        })
    }
    public func defaultDesign() -> some View {
        return self.foregroundColor(.white)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HStack{
                RoundedButton(action: {
                    
                }) {
                    HStack{
                        Spacer()
                        Text("HI")
                        Spacer()
                    }
                }.defaultDesign().padding(.horizontal,80)
            }
        }
    }
}
