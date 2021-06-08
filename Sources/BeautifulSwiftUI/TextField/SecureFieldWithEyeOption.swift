//
//  SecureFieldWithEyeOption.swift
//  powerfox-widget-ios
//
//  Created by Hannes Harnisch on 19.03.21.
//

import SwiftUI

public struct SecureFieldWithEyeOption: View {
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
        if showPassword{
            RoundedTextField(placeholder, text: $text,button: Button(action: {showPassword.toggle()}, label: {
                Image(systemName: "eye")
            }),onEdit: onEdit,onCommit:onCommit)
        }else{
            RoundedTextField(placeholder, text: $text,button: Button(action: {showPassword.toggle()}, label: {
                Image(systemName: "eye.slash")
            }),secured: true,onEdit: onEdit,onCommit:onCommit)
        }
    }
    public func defaultDesign() -> some View {
        return self.foregroundColor(.primary).frame(height:60)
    }
}

struct SecureFieldWithEyeOption_Previews: PreviewProvider {
    static var previews: some View {
        SecureFieldWithEyeOption("Password", text: .constant("")).defaultDesign().padding()
    }
}
