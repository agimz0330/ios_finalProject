//
//  iconView.swift
//  finalProject
//
//  Created by User08 on 2021/1/11.
//

import SwiftUI

struct iconView: View {
    let MyYellow:Color = Color(red: 253/255, green: 251/255, blue: 239/255)
    
    var body: some View {
        ZStack{
            MyYellow
                .edgesIgnoringSafeArea(.all)
            HStack {
                Button(action: {
                    UIApplication.shared.setAlternateIconName(nil)
                }) {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                }
                Button(action: {
                    UIApplication.shared.setAlternateIconName("iconn")
                }) {
                    Image("iconn")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                }
                Button(action: {
                    UIApplication.shared.setAlternateIconName("iconnn")
                }) {
                    Image("iconnn")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                }
            }
            .shadow(radius: 20)
            .frame(height: 200)
            .padding()
            .navigationTitle("Choose your icon!")
        }
    }
}

struct iconView_Previews: PreviewProvider {
    static var previews: some View {
        iconView()
    }
}
