//
//  CustomTextField.swift
//
//  Created by Hannes Harnisch on 19.03.21.
//

import SwiftUI

public struct RoundedTextField: View {
    @Environment(\.errorColor) var errorColor
    @Environment(\.textFieldBackground) var textFieldBackground
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
    public init(_ placeholder:String, text: Binding<String>,error: Binding<String?> = .constant(nil), onEdit: @escaping (Bool) -> (), onCommit: @escaping () -> ()) {
        self.placeholder = placeholder
        self._text = text
        self._error = error
        self.onEdit = onEdit
        self.onCommit = onCommit
    }
    public var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack{
                    if self.text == "" {
                        HStack{
                            Text(placeholder).font(.body).foregroundColor(.primary).opacity(0.6).padding(.vertical)
                            Spacer()
                        }.allowsHitTesting(false)
                    }
                    TextField("", text: $text) { finished in
                        DispatchQueue.main.async {
                            self.error = nil
                        }
                        self.onEdit(finished)
                    } onCommit: {
                        self.onCommit()
                    }.frame(height: 10).foregroundColor(.primary)
                }
            }.frame(height:20).padding().roundedRectBackground(color: textFieldBackground).roundedRectOverlay(color: error == nil ? Color.primary.opacity(0.5) : errorColor.opacity(0.6))
            if error != nil {
                Text(error!).font(.caption).foregroundColor(errorColor.opacity(0.8)).padding(.leading).padding(.top,-5)
            }
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextField("Text", text: .constant(""),error: .constant(nil)).padding()
    }
}
