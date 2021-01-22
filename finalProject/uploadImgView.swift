//
//  uploadImgView.swift
//  finalProject
//
//  Created by User07 on 2021/1/5.
//

import SwiftUI

// 上傳本機圖片
struct uploadImgView: View {
    @State private var showPickedPhoto = false
    
    var body: some View {
        VStack{
            Button(action: {
                showPickedPhoto = true
            }, label: {
                Image(systemName: "photo")
            })
            .sheet(isPresented: $showPickedPhoto, content: {
                ImgPickView()
            })
        }
    }
}

struct uploadImgView_Previews: PreviewProvider {
    static var previews: some View {
        uploadImgView()
    }
}
