//
//  DefaultAcitivtyIndicator.swift
//  
//
//  Created by Hannes Harnisch on 07.06.21.
//

import SwiftUI

public struct DefaultAcitivtyIndicator: View {
    @State var progress = 0.0
    public var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Circle().stroke(style: StrokeStyle(lineWidth: min(geometry.size.height,geometry.size.width)/10 ,lineCap: .round)).foregroundColor(.gray).opacity(0.2).padding().padding(min(geometry.size.height,geometry.size.width)/20)
                CircleLoader(progress: $progress, color: .blue, lineWidth: min(geometry.size.height,geometry.size.width)/10).padding().onAppear {
                    withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        self.progress = 1
                    }
                }.padding(min(geometry.size.height,geometry.size.width)/20)
            }
        }
    }
    public func defaultBackground() -> some View {
        self.background(Rectangle().cornerRadius(10).foregroundColor(.white).shadow(radius: 5))
    }
}
struct CircleLoader: View {
    @Binding var progress: Double
    var color:Color
    var lineWidth:CGFloat
    var body: some View {
        VStack{
            CircleLoadingShape(progress: max(0.0,min(1.0,abs(self.progress)))).stroke(style: StrokeStyle(lineWidth: lineWidth,lineCap: .round)).foregroundColor(color)
        }
    }
}
struct CircleLoadingShape:Shape{
    var progress:Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let endAngle = ((progress * 360) - 90)
        let startAngle = ((progress * 360) - (140 + (abs(progress - 0.5) * 60)))
        path.addArc(center: CGPoint(x:rect.size.width/2,y:rect.size.height/2), radius: min(rect.size.width/2,rect.size.height/2), startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: progress <= 0)
        return path
    }
    var animatableData: Double {
        get { return progress }
        set { progress = newValue }
    }
    
}
struct DefaultAcitivtyIndicator_Previews: PreviewProvider {
    static var previews: some View {
        DefaultAcitivtyIndicator().defaultBackground().frame(width: 150, height: 150)
    }
}
