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
    private var button:Button<Image>? = nil
    private var secured:Bool
    public init(_ placeholder:String, text: Binding<String>,error: Binding<String?> = .constant(nil),button:Button<Image>? = nil,secured:Bool = false) {
        self.placeholder = placeholder
        self.button = button
        self._text = text
        self._error = error
        self.onEdit = {_ in }
        self.onCommit = { }
        self.secured = secured
    }
    public init(_ placeholder:String, text: Binding<String>,error: Binding<String?> = .constant(nil), button:Button<Image>? = nil,secured:Bool = false,onEdit: @escaping (Bool) -> (), onCommit: @escaping () -> ()) {
        self.placeholder = placeholder
        self._text = text
        self._error = error
        self.onEdit = onEdit
        self.button = button
        self.onCommit = onCommit
        self.secured = secured
    }
    public var body: some View {
        GeometryReader{geometry in
            VStack(alignment: .leading){
                HStack{
                    ZStack{
                        if self.text == "" {
                            HStack{
                                Text(placeholder).font(.body).foregroundColor(.primary).opacity(0.6).padding(.vertical)
                                Spacer()
                            }.allowsHitTesting(false)
                        }
                        if secured{
                            SecureField("", text: $text, onCommit: onCommit).frame(height:geometry.size.height - 20).foregroundColor(.primary)
                        }else{
                            TextField("", text: $text) { finished in
                                DispatchQueue.main.async {
                                    self.error = nil
                                }
                                self.onEdit(finished)
                            } onCommit: {
                                self.onCommit()
                            }.frame(height:geometry.size.height - 20).foregroundColor(.primary)
                        }
                    }.frame(height:geometry.size.height - 20)
                    if button != nil {
                        Divider().padding(1)
                        button.foregroundColor(.primary)
                    }
                }.padding().frame(height:geometry.size.height - 10).roundedRectBackground(color: textFieldBackground).roundedRectOverlay(color: error == nil ? Color.primary.opacity(0.5) : errorColor.opacity(0.6))
                if error != nil {
                    Text(error!).font(.caption).foregroundColor(errorColor.opacity(0.8)).padding(.leading).padding(.top,-8)
                }
            }
        }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RoundedTextField("Text", text: .constant(""),error: .constant(nil),button: Button(action: {}, label: {
                Image(systemName: "wifi")
            })).frame(height:40).padding()
            Spacer()
            RoundedTextField("Text", text: .constant(""),error: .constant(nil),button: Button(action: {}, label: {
                Image(systemName: "wifi")
            }),secured: true).frame(height:40).padding()
        }
    }
}
