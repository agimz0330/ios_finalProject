//
//  Thing.swift
//  HW4
//
//  Created by User08 on 2020/11/20.
//

import Foundation

struct Thing: Identifiable, Codable{
    let id = UUID()
    var startTime: Date
    var finishTime: Date
    var costMoney: Bool
    var money: Double
    var activity: String
    var classification: String
    var description: String
}
