//
//  Luck.swift
//  finalProject
//
//  Created by User08 on 2021/1/11.
//
import Foundation

struct LuckThing: Codable, Hashable{
    let hope: String?
    let sick: String?
    let person: String?
    let lost: String?
    let newHome: String?
    let moveHome: String?
    let marry: String?
    let travel: String?
    let romance: String?
    
    enum CodingKeys: String, CodingKey{
        case hope = "願望"
        case sick = "疾病"
        case person = "盼望的人"
        case lost = "遺失物"
        case newHome = "蓋新居"
        case moveHome = "搬家"
        case marry = "結婚"
        case travel = "旅行"
        case romance = "交往"
    }
}

struct myLuck: Codable, Hashable{
    let type: String
    let poem: String
    let explain: String
    let result: LuckThing
    let note: String?
}
