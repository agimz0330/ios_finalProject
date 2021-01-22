//
//  ThingData.swift
//  HW4
//
//  Created by User08 on 2020/11/20.
//

import Foundation
import Combine

class ThingData: ObservableObject{
    @Published var things = [Thing]()
    var num = 0
    var cancel: AnyCancellable?
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "things"){
            let decoder = JSONDecoder()
            if let decodeData = try? decoder.decode([Thing].self, from: data){
                things = decodeData
            }
        }
        
        cancel = $things
            .sink(receiveValue: {(value) in
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(value){
                    UserDefaults.standard.set(data, forKey: "things")
                }
            })
    }
}
