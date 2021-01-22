//
//  FirstView.swift
//  finalProject
//
//  Created by User07 on 2021/1/5.
//

import Foundation
import SwiftUI
import WebKit

struct webView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ContentView {
        let firstView = FirstView()
        if let url = URL(string: "https://www.thelittleprince.com") {
            let request = URLRequest(url: url)
            firstView.load(request)
        }
        return firstView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        <#code#>
    }
    
    typealias UIViewType = WKWebView
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
