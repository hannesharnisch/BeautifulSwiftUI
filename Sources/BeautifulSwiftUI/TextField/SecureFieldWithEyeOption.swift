//
//  SecureFieldWithEyeOption.swift
//  powerfox-widget-ios
//
//  Created by Hannes Harnisch on 19.03.21.
//

import SwiftUI

public struct SecureFieldWithEyeOption: View {
    @Environment(\.errorColor) var errorColor
    @Environment(\.textFieldBackground) var textFieldBackground
    @State private var showPassword = false
    @Binding private var text:String
    private var placeholder:String
    @Binding private var error:String?
    private var onEdit: (Bool) -> ()
    private var onCommit: () -> ()
    public init(_ placeholder:String, text: Binding<String>,error: Binding<String?> = .constant(nil)) {
        self.placeholder = placeholder
        self._text = text
        self._error = error
        self.onEdit = {_ in }
        self.onCommit = { }
    }
    public init(_ placeholder:String, text: Binding<String>,error: Binding<String?> = .constant(nil),onEdit: @escaping (Bool) -> (), onCommit: @escaping () -> ()) {
        self.placeholder = placeholder
        self._text = text
        self._error = error
        self.onEdit = onEdit
        self.onCommit = onCommit
    }
    public var body: some View {
        VStack(alignment: .leading){
            core.frame(height:20).padding().roundedRectBackground(color: textFieldBackground).roundedRectOverlay(color: error == nil ? Color.primary.opacity(0.5) : errorColor.opacity(0.6))
            if error != nil {
                Text(error!).foregroundColor(errorColor.opacity(0.8)).font(.body).padding(.leading).padding(.top,-5)
            }
        }
    }
    var core: some View {
        HStack{
            ZStack{
                if self.text == "" {
                    HStack{
                        Text(placeholder).font(.body).opacity(0.6).padding(.vertical)
                        Spacer()
                    }.allowsHitTesting(false)
                }
                if showPassword {
                    TextField("", text: self.$text) { (finished) in
                        self.error = nil
                        self.onEdit(finished)
                    } onCommit: {
                        self.onCommit()
                    }.frame(height: 10)
                }else{
                    SecureField("",text: self.$text) {
                        self.error = nil
                        self.onCommit()
                    }.frame(height: 10)
                }
            }
            Divider().padding(1)
            Button(action: {
                showPassword.toggle()
            }, label: {
                Image(systemName: showPassword ? "eye" : "eye.slash")
            })
        }
    }
    func defaultDesign() -> some View {
        return self.foregroundColor(.primary)
    }
}

struct SecureFieldWithEyeOption_Previews: PreviewProvider {
    static var previews: some View {
        SecureFieldWithEyeOption("Password", text: .constant("")).defaultDesign().padding()
    }
}
