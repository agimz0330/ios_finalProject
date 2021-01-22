//
//  ImgPickView.swift
//  finalProject
//
//  Created by User07 on 2021/1/5.
//

import SwiftUI

struct ImgPickView: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        return controller
    }
    
}

struct ImgPickView_Previews: PreviewProvider {
    static var previews: some View {
        ImgPickView()
    }
}
