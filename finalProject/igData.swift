//
//  igData.swift
//  finalProject
//
//  Created by User08 on 2021/1/9.
//

import Foundation

struct instagramProfileData : Identifiable { // 個人資料
    let id = UUID()
//    var id : String
    var profile_pic_url_hd : String // 頭像網址
    var username : String // 使用者名稱
    var is_verified : Bool
    var edge_followed_by : Int
    var edge_follow : Int
    var full_name : String
    var biography : String // 自我介紹
    var external_url : String
    var edge_owner_to_timeline_media_postcount : Int
}

struct instagramPostData : Identifiable { // 每則貼文的資料
    let id = UUID()
//    var id : String
    var display_url : String // 圖片網址
    var text : String // 內容
    var comment : Int // 留言數
    var liked : Int // 愛心數
//    var thumbnail : String
    var __typename : String
    var shortcode : String
    var thumbnail_src: String // 縮圖
}

struct instagramVideoData: Identifiable {
    var id : String
    var video_url : String
    var text : String
}

struct instagramSideCarData: Identifiable {
    var id : String
    var display_url : String
    var videoData : instagramVideoData
}
