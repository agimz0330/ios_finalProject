//
//  addDataView.swift
//  HW4
//
//  Created by User08 on 2020/11/19.
//

import SwiftUI

struct addDataView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var startTime = Date()
    @State private var finishTime = Date()
    
    @State private var pickActionIndex = 0
    @State private var money:Double = 0.0
    @State private var isExpanded = true
    @State private var costMoney = false
    @State private var description = ""
    @State private var classIndex: [Int] = [0,0,0,0,0,0,0,0,0,0,0]
    
    var thingData: ThingData
    var editThing: Thing?
    
    var body: some View {
        let redColor = Color(red: 190/255, green: 131/255, blue: 117/255)
        NavigationView{
            Form{
                DatePicker("今天是：", selection: $startTime, displayedComponents: .date)
                    .accentColor(.black)
                HStack{
                    Text("From")
                    DatePicker("開始", selection: $startTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .accentColor(.black)
                    Spacer()
                    Text("To")
                    DatePicker("結束", selection: $finishTime, in: startTime..., displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .accentColor(.black)
                }

                ChooseThing(isExpanded: $isExpanded, pickActionIndex: $pickActionIndex, classIndex: $classIndex)

                Toggle(costMoney ? "花錢" : "不花錢", isOn: $costMoney)
                    .onChange(of: costMoney, perform: { value in
                        if !costMoney{
                            money = 0
                        }
                    })
                if costMoney{
                    HStack{
                        Spacer()
                        Image(systemName: "dollarsign.circle")
                        Text("\(money, specifier: "%.0f")")
                    }
                    Slider(value: $money, in: 0...1000, step: 10)
                }
                TextField("加點說明：", text: $description)

                ZStack{
                    Text("Fighting")
                        .font(.custom("WildySansRegular", size: 100))
                        .foregroundColor(Color.yellow)
                        .offset(x: 10)
                    Text("Fighting")
                        .font(.custom("WildySansRegular", size: 100))
                        .foregroundColor(redColor)
                        .offset(x: 15, y: 5)
                }
            }
            .navigationBarItems(trailing: Button("Save"){
                let oneThing = Thing(startTime: self.startTime, finishTime: self.finishTime, costMoney: self.costMoney, money: self.money, activity: activities[pickActionIndex].action, classification: activities[pickActionIndex].classification[classIndex[pickActionIndex]], description: self.description)
                
                if let editThing = self.editThing{
                    let index = self.thingData.things.firstIndex{
                        $0.id == editThing.id
                    }!
                    self.thingData.things[index] = oneThing
                }else{
                    self.thingData.things.insert(oneThing, at: 0)
                }
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear{
                if let editThing = self.editThing{
                    self.startTime = editThing.startTime
                    self.finishTime = editThing.finishTime
                    self.costMoney = editThing.costMoney
                    self.money = editThing.money
                    self.costMoney = editThing.costMoney
                    self.description = editThing.description
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct addDataView_Previews: PreviewProvider {
    static var previews: some View {
        addDataView(thingData: ThingData())
    }
}

struct ChooseThing: View {
    @Binding var isExpanded: Bool
    @Binding var pickActionIndex: Int
    @Binding var classIndex: [Int]
    
    var body: some View {
        DisclosureGroup("在\(activities[pickActionIndex].action): \(activities[pickActionIndex].classification[classIndex[pickActionIndex]])", isExpanded: $isExpanded){
            
            Picker(selection: $pickActionIndex, label: Text("pick")){
                ForEach(activities.indices){(index) in
                    Text(activities[index].action)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 250, height: 150)
            .clipped()
            
            switch pickActionIndex{
            case 0://吃飯
                Picker("做", selection: $classIndex[0]){
                    ForEach((activities[0].classification).indices){(index) in
                        Text((activities[0].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            case 1://睡覺
                Picker("做", selection: $classIndex[1]){
                    ForEach((activities[1].classification).indices){(index) in
                        Text((activities[1].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            case 2://逛街
                Picker("做", selection: $classIndex[2]){
                    ForEach((activities[2].classification).indices){(index) in
                        Text((activities[2].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            case 3://讀書
                myPicker(classIndex: $classIndex, i: 3)
            case 4://通勤
                Picker("做", selection: $classIndex[4]){
                    ForEach((activities[4].classification).indices){(index) in
                        Text((activities[4].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            case 5://遊戲
                Picker("做", selection: $classIndex[5]){
                    ForEach((activities[5].classification).indices){(index) in
                        Text((activities[5].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            case 6://上課
                myPicker(classIndex: $classIndex, i: 6)
            case 7://作業
                myPicker(classIndex: $classIndex, i: 7)
            case 8://聊天
                Picker("做", selection: $classIndex[8]){
                    ForEach((activities[8].classification).indices){(index) in
                        Text((activities[8].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            case 9://梳洗
                Picker("做", selection: $classIndex[9]){
                    ForEach((activities[9].classification).indices){(index) in
                        Text((activities[9].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            case 10://耍廢
                Picker("做", selection: $classIndex[10]){
                    ForEach((activities[10].classification).indices){(index) in
                        Text((activities[10].classification)[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            default:
                Text("Something Wrong...")
            }
        }
    }
}

struct myPicker: View {
    @Binding var classIndex: [Int]
    var i: Int
    
    var body: some View{
        let grayColor = Color(red: 235/255, green: 235/255, blue: 235/255)
        ScrollView(.horizontal){
            HStack{
                ForEach((activities[i].classification).indices){(index) in
                    ZStack{
                        Button(action: {
                            classIndex[i] = index
                        }, label: {
                            Text((activities[i].classification)[index])
                                .font(.custom("", size: 13.5))
                                .foregroundColor(.black)
                        })
                        .frame(width: 75, height: 25)
                        .cornerRadius(7.0)
                        .padding(2)
                        
                        if index==classIndex[i]{
                            Color.white
                                .frame(width: 75, height: 25)
                                .cornerRadius(7.0)
                                .padding(2)
                            Text((activities[i].classification)[index])
                                .font(.custom("", size: 13.5))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .frame(height: 30)
            .background(grayColor)
            .cornerRadius(7.0)
        }
    }
}
