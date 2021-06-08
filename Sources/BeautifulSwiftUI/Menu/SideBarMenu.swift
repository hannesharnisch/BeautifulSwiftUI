//
//  SideBarMenu.swift
//  
//
//  Created by Hannes Harnisch on 08.06.21.
//

import SwiftUI

public struct MenuItem:Identifiable, Equatable {
    public let id:Int
    public let image:Image
    public let name:String
    public init(index:Int,image:Image,name:String){
        self.id = index
        self.image = image
        self.name = name
    }
}
public struct DefaultSideBarMenu<Content: View>: View {
    @Binding private var selection:Int
    @Binding private var showSideBar:Bool
    @State var menuItems:[MenuItem]
    private var viewForItem:(Int) -> Content
    public init(_ presented:Binding<Bool>,selection:Binding<Int>,items:[MenuItem], viewFor:@escaping (Int)->Content) {
        self._showSideBar = presented
        self.viewForItem = viewFor
        self._selection = selection
        self._menuItems = State(initialValue: items)
    }
    public var body: some View {
        SideBarMenu($showSideBar, selection: $selection) { _ in
            VStack {
                ForEach(self.menuItems) { item in
                    VStack{
                        TabButton(item: item, selectedTab: $selection)
                    }
                }
                Spacer()
                Button(action: {withAnimation {self.showSideBar = false}}, label: {
                    Image(systemName: "xmark")
                }).font(.headline).foregroundColor(.white).padding().background(Circle().foregroundColor(.red.opacity(0.8)))
            }.padding(.vertical,60).frame(height:UIScreen.main.bounds.height).edgesIgnoringSafeArea(.vertical)
        } viewFor: { index in
            self.viewForItem(index)
        }
        
    }
}
struct TabButton:View {
    var item:MenuItem
    @Binding var selectedTab:Int
    var body: some View {
        Button(action: {
            withAnimation {
                self.selectedTab = item.id
            }
        }) {
            item.image.font(.headline).foregroundColor(selectedTab == item.id ? .white : Color.gray.opacity(0.8)).frame(maxHeight:100)
        }
    }
}

public struct SideBarMenu<Content:View,SideMenu:View>: View {
    @Binding private var selection:Int
    @Binding private var showSideBar:Bool
    private var viewForItem:(Int) -> Content
    private var sideMenu:(Int) -> SideMenu
    public init(_ presented:Binding<Bool>,selection:Binding<Int>,sideMenu:@escaping (Int) -> SideMenu,viewFor:@escaping (Int)->Content) {
        self._showSideBar = presented
        self.viewForItem = viewFor
        self.sideMenu = sideMenu
        self._selection = selection
    }
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                self.presentedView.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                HStack{
                    VStack{
                        self.sideMenu(selection)
                    }.frame(width: 80).background(Color.black.edgesIgnoringSafeArea(.vertical)).padding(.leading, self.showSideBar ? CGFloat(0) : CGFloat(-(80)))
                    Spacer()
                }
            }.frame(width: geometry.size.width,height:geometry.size.height)
        }
    }
    var presentedView: some View {
        ZStack(alignment:.center){
            viewForItem(selection)
            if self.showSideBar {
                Color.gray.opacity(0.0001).onTapGesture {
                    withAnimation(.easeIn(duration:0.25)) {
                        self.showSideBar = false
                    }
                }
            }
        }
    }
    func toggleSideBar() {
        withAnimation {
            self.showSideBar.toggle()
        }
    }
}

//Testing
struct TestView:View{
    @State var selection = 0
    @State var open = true
    var body: some View {
        VStack{
            DefaultSideBarMenu($open, selection: $selection, items: [MenuItem(index: 0, image: Image(systemName: "house.fill"), name: "home"),MenuItem(index: 1,image: Image(systemName: "gear"), name: "settings"),MenuItem(index: 2,image: Image(systemName: "chevron.right"), name: "s")]) { index in
                VStack{
                    switch selection {
                    case 0:
                        Text("Home")
                    default:
                        Text("HI")
                    }
                    Spacer()
                    Text("HIEI")
                }
            }
        }
    }
}
struct SideBarMenu_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
