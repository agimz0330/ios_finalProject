//
//  fbLoginView.swift
//  finalProject
//
//  Created by User08 on 2021/1/22.
//

import SwiftUI
import FacebookLogin

struct fbLoginView: View {
    @Binding var login: Bool
    @State var showAlert = false
    
    var body: some View {
        ZStack{
            Button(action: {
                let manager = LoginManager()
                manager.logIn(permissions: [.email]) { (result) in
                    if case LoginResult.success(granted: _, declined: _, token: _) = result {
                        login = true
                        showAlert = true
                        print("login ok")
                    } else {
                        login = false
                        showAlert = false
                        print("login fail")
                    }
                }
                
            }) {
                Text("FB Login")
            }
            .alert(isPresented: $showAlert) { () -> Alert in
                return Alert(title: Text("登入成功"))
            }
        }
    }
}

struct FBFirst:View {
    @State var login = false

    var body: some View{
        NavigationView{
            VStack{
                fbLoginView(login: $login)
                if login == true{
                    NavigationLink(destination: FBSecond()){
                        Text("Enter")
                    }
                }
                else{
                    Text("請先登入成功")
                }
            }
            .navigationBarTitle("Facebook登入", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct FBSecond:View{
    @State private var showAddData = false

    var body: some View{
        let redColor = Color(red: 200/255, green: 141/255, blue: 127/255)
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            TabView{
                nowTimeView()
                    .tabItem{
                        Text("HOME")
                        Image(systemName: "house")
                    }
                doListView()
                    .tabItem {
                        Text("TODAY")
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    }
                Text("")
                    .tabItem {
                        Text("")
                    }
                igView()
                    .tabItem {
                        Text("IG")
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    }
                myLuckView()
                    .tabItem {
                        Text("LUCKY")
                        Image(systemName: "timer")
                    }
            }
            .accentColor(redColor)
            .sheet(isPresented: $showAddData){
                addDataView(thingData: ThingData())
            }
            
            Button(action: {
                showAddData = true
            }, label:{
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(x: 0, y: -13)
                    .accentColor(redColor)
            })
        }
        .navigationBarHidden(true)
    }
}
