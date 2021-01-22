//
//  doRowView.swift
//  HW4
//
//  Created by User08 on 2020/11/20.
//

import SwiftUI

struct doRowView: View {
    var thing: Thing
    
    var body: some View {
        let redColor = Color(red: 190/255, green: 131/255, blue: 117/255)
        
        VStack(alignment: .leading, spacing: 3){
            HStack{
                Image(systemName: "paperclip")
                Text("\(thing.activity)")
                    .font(.custom("HanyiSentyFingerPainting", size: 50))
//                    .foregroundColor(redColor)
                Spacer()
                if !thing.costMoney{
                    Text("● Free ")
                        .foregroundColor(.green)
                }else{
                    Text("NT $\(thing.money, specifier: "%.0f")")
                        .foregroundColor(.red)
                }
            }
            HStack(alignment: .top, spacing: 10){
                VStack(alignment: .leading, spacing: 5){
                    HStack(alignment: .bottom){
                        Text("\(thing.classification)")
                            .font(.custom("HanyiSentyChalkOriginal", size: 18))
                            .foregroundColor(Color.white)
                            .padding([.trailing, .leading], 10)
                            .background(redColor)
                            .cornerRadius(10)
                        Text("\(thing.startTime ... thing.finishTime)")
                            .font(.custom("WildySansRegular", size: 28))
                            .foregroundColor(redColor)
                    }
                    
                    Text("\(thing.description)")
                        .font(.custom("HanyiSentyChalkOriginal", size: 15))
                        .foregroundColor(redColor)
                }
            }
            Text("")
            HStack{
                Spacer()
                
                let calendar = Calendar.current
                let today = calendar.startOfDay(for: thing.startTime)
                let startAngle = CGFloat(thing.startTime.timeIntervalSince(today)/(86400))
                let finishAngle = CGFloat(thing.finishTime.timeIntervalSince(today)/(86400))
                
                ZStack{
                    Circle()
                        .stroke(Color(red: 215/255, green: 210/255, blue: 205/255), lineWidth: 10)
                        .frame(width: 50, height: 50)
                        .rotationEffect(.degrees(90))
                    Circle()
                        .trim(from: startAngle, to: finishAngle)
                        .stroke(Color(red: 200/255, green: 141/255, blue: 127/255), lineWidth: 18)
                        .frame(width: 50, height: 50)
                        .rotationEffect(.degrees(-90))
                }
            }
        }
        .padding()
        .border(redColor, width: 3)
        .background(Color(red: 236/255, green: 224/255, blue: 214/255))
    }
}

struct doRowView_Previews: PreviewProvider {
    static var previews: some View {
        doRowView(thing: Thing(
                    startTime: DateComponents(calendar: Calendar.current, year: 2020, month: 11, day: 25, hour: 0, minute: 1, second: 0).date!,
                    finishTime: DateComponents(calendar: Calendar.current, year: 2020, month: 11, day: 25, hour: 23, minute: 45, second: 0).date!,
                    costMoney: false,
                    money: 0.0,
                    activity: "作業",
                    classification: "ios",
                    description: "噴錯誤啊啊啊啊啊ㄚ"))
    }
}

