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
        ZStack{
            HStack{
                VStack{
                    self.sideMenu(selection).padding(.vertical)
                }.frame(width: 80).background(Color.black.edgesIgnoringSafeArea(.vertical)).offset(x: self.showSideBar ? CGFloat(0) : CGFloat(-(80))).padding(.trailing, self.showSideBar ? CGFloat(0) : CGFloat(-(80)))
                self.presentedView
            }
        }
    }
    var presentedView: some View {
        ZStack(alignment:.center){
            viewForItem(selection).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center).padding(.trailing,showSideBar ? CGFloat(-80) : CGFloat(0))
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
        self.showSideBar.toggle()
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
