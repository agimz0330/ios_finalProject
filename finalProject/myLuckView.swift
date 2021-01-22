//
//  myLuckView.swift
//  finalProject
//
//  Created by User08 on 2021/1/11.
//

import SwiftUI

struct myLuckView: View {
    let myLuck: [myLuck] = jsonTo()
    var num = Int.random(in: 0...99)
    
    var body: some View {
        let bgColor: Color = Color(red: 58/255, green: 68/255, blue: 77/255)
        let fontColor: Color = Color(red: 154/255, green: 137/255, blue: 144/255)
        let imgNum = Int.random(in: 0...24)
        
        ZStack{
            bgColor
            VStack{
                VStack(alignment: .leading){
                    if myLuck[num].result.hope != nil {
                        Text("願望：\(myLuck[num].result.hope!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.sick != nil {
                        Text("疾病：\(myLuck[num].result.sick!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.person != nil {
                        Text("盼望的人：\(myLuck[num].result.person!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.lost != nil {
                        Text("遺失物：\(myLuck[num].result.lost!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.newHome != nil {
                        Text("蓋新居：\(myLuck[num].result.newHome!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.moveHome != nil {
                        Text("搬家：\(myLuck[num].result.moveHome!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.marry != nil {
                        Text("嫁娶：\(myLuck[num].result.marry!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.travel != nil {
                        Text("旅行：\(myLuck[num].result.travel!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                    if myLuck[num].result.romance != nil{
                        Text("交往：\(myLuck[num].result.romance!)")
                            .modifier(luckTextModifier(textSize: 14))
                    }
                }
                ZStack{
                    fontColor
                        .frame(width: 300, height: 160)
                    Image("IMG_\(imgNum)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 240, height: 180)
                        .clipped()
                }
                VStack{
                    //Text("CHOOSE：")
                    //    .modifier(luckTextModifier(textSize: 14))
                    Text("\(myLuck[num].type)")
                        .font(.custom("KouzanBrushFont", size: 50))
                        .foregroundColor(fontColor)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                        .background(Color(red: 210/255, green: 210/255, blue: 210/255))
                        .cornerRadius(30)
                        .padding(10)
                }
                Text("\(myLuck[num].explain)")
                    .modifier(luckTextModifier(textSize: 18))
                
                if myLuck[num].note != nil{
                    Text("\(myLuck[num].note!)")
                        .modifier(luckTextModifier(textSize: 14))
                        .padding()
                }
                Spacer()
                Text("\(myLuck[num].poem)")
                    .modifier(luckTextModifier(textSize: 16))
                    .padding(20)
            }
            .padding()
        }
    }
}

struct myLuckView_Previews: PreviewProvider {
    static var previews: some View {
        myLuckView()
    }
}

struct luckTextModifier: ViewModifier {
    var textSize: CGFloat
    let fontColor: Color = Color(red: 154/255, green: 137/255, blue: 144/255)
    func body(content: Content) -> some View {
        content
            .font(.custom("", size: textSize))
            .foregroundColor(fontColor)
    }
}

func jsonTo() -> [myLuck] {
    let url = Bundle.main.url(forResource: "淺草籤", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    let myDatas = try? decoder.decode([myLuck].self, from: data)
    return myDatas!
}
