//
//  Activity.swift
//  HW4
//
//  Created by User08 on 2020/11/20.
//

import Foundation
struct Activity{
    var action:String
    var classification:[String]
}

var subjects: [String] = ["數值分析", "Python", "影像處理", "電腦圖學", "巨量資料", "作業系統", "軟體工程", "ios", "社團", "通識"]
var activities: [Activity] = [Activity(action: "吃飯", classification: ["早餐", "午餐", "晚餐"]),
                              Activity(action: "睡覺", classification: ["晚安覺", "回籠覺"]),
                              Activity(action: "逛街", classification: ["蝦皮", "屈臣氏", "淘寶", "實體店面"]),
                              Activity(action: "讀書", classification: subjects),
                              Activity(action: "通勤", classification: ["走路", "火車", "客運", "捷運", "公車"]),
                              Activity(action: "遊戲", classification: ["吃雞", "小遊戲"]),
                              Activity(action: "上課", classification: subjects),
                              Activity(action: "作業", classification: subjects),
                              Activity(action: "聊天", classification: ["跟朋友", "跟男朋友", "跟女朋友", "跟網友", "跟陌生人"]),
                              Activity(action: "梳洗", classification: ["洗漱", "洗澡", "曬衣服", "打掃", "上廁所", "吹頭髮"]),
                              Activity(action: "耍廢", classification: ["滑手機", "看電視", "看小說", "看電影", "打滾", "其他", "我不知道"])]
