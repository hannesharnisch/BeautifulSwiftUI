//
//  ImageActivityIndicator.swift
//  
//
//  Created by Hannes Harnisch on 08.06.21.
//

import SwiftUI

public struct ImageActivityIndicator: View {
    @State var animation:Bool = false
    private var image:Image
    private var loadingStyle:ImageLoadingStyle
    public init(_ image:Image = Image(systemName: "gear"),style:ImageLoadingStyle = .rotating()){
        self.image = image
        self.loadingStyle = style
    }
    public var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment:.center){
            switch self.loadingStyle {
            case .rotating(let clockwise,let an):
                image.resizable().scaledToFit().padding().rotationEffect(animation ? .degrees(clockwise ? 360 : -360):.zero).onAppear {
                    withAnimation(an.repeatForever(autoreverses: false)){
                        self.animation.toggle()
                    }
                }
            case .jumping(let an):
                image.resizable().scaledToFit().padding().offset(y:animation ? -geometry.size.height/5:geometry.size.height/20).padding(.top).onAppear {
                    withAnimation(an.repeatForever(autoreverses: true)){
                        self.animation.toggle()
                    }
                }
            case .shaking(let degrees,let an):
                image.resizable().scaledToFit().padding().rotationEffect(animation ? -degrees:degrees).onAppear {
                    withAnimation(an.repeatForever(autoreverses: true)){
                        self.animation.toggle()
                    }
                }
            }
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
    public func defaultBackground() -> some View {
        self.background(Rectangle().cornerRadius(10).foregroundColor(.white).shadow(radius: 5))
    }
}
public enum ImageLoadingStyle {
    case jumping(animation:Animation = Animation.easeInOut(duration:1))
    case rotating(clockwise:Bool = true,animation:Animation = Animation.linear(duration:3))
    case shaking(degrees:Angle = Angle.degrees(20),animation:Animation = Animation.linear(duration:0.5))
}
struct ImageActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ImageActivityIndicator(Image(systemName: "clock"), style: .shaking()).defaultBackground().frame(width: 100, height: 100, alignment: .center).padding()
        
    }
}
