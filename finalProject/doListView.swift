//
//  doListView.swift
//  HW4
//
//  Created by User08 on 2020/11/19.
//

import SwiftUI

struct doListView: View {
    @ObservedObject var thingData = ThingData()
    @State private var showAddData = false
    @State private var searchText = ""
    
    var filtedThings: [Thing]{
        return thingData.things.filter({searchText.isEmpty ? true : $0.activity.contains(searchText)})
    }
    
    var body: some View {
        let bgColor = Color(red: 246/255, green: 234/255, blue: 224/255)
        let redColor = Color(red: 200/255, green: 141/255, blue: 127/255)
        NavigationView{
            ZStack{
                bgColor
                    .edgesIgnoringSafeArea(.all)
                List{
//                    SearchView(text: $searchText)
                    ForEach(filtedThings){(thing) in
                        NavigationLink(destination: addDataView(thingData: self.thingData, editThing: thing)){
                            doRowView(thing: thing)
                        }
                    }
                    .onMove{(indexSet, index) in
                        self.thingData.things.move(fromOffsets: indexSet, toOffset: index)
                    }
                    .onDelete{(indexSet) in
                        self.thingData.things.remove(atOffsets: indexSet)
                    }
                    .listRowBackground(bgColor)
                }
                .navigationBarTitle("Today I do :")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            showAddData = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                })
                .navigationBarItems(leading: EditButton().accentColor(redColor))
                .disabled(thingData.things.count > 999)
                .sheet(isPresented: $showAddData){
                    addDataView(thingData: self.thingData)
                }
            }
        }
    }
}

struct doListView_Previews: PreviewProvider {
    static var previews: some View {
        doListView()
    }
}
