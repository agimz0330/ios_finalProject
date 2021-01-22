//
//  nowTimeView.swift
//  HW4
//
//  Created by User08 on 2020/11/18.
//

import SwiftUI

struct nowTimeView: View {
    @State private var nowTime = "2000-Mar-31 Sun\n\t\t00:03:31"
    
    var body: some View {
        let redColor = Color(red: 190/255, green: 131/255, blue: 117/255)
        ZStack{
            Color(red: 246/255, green: 234/255, blue: 224/255)
                .edgesIgnoringSafeArea(.all)
//            Image("bg")
//                .resizable()
//                .scaledToFill()
//                .offset(y: -150)
            VStack{
                Text("\n時間管理大師")
                    .font(.custom("HanyiSentyCrayon", size: 60))
                Text("\(nowTime)")
                    .font(.custom("WildySansRegular", size: 40))
                    .foregroundColor(redColor)
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(_) in
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MMM-dd E\n\t\tHH:mm:ss"
                            let now = Date()
                            nowTime = formatter.string(from: now)
                        })
                    }
            }
            .offset(y: 50)
        }
    }
}

struct nowTimeView_Previews: PreviewProvider {
    static var previews: some View {
        nowTimeView()
    }
}

