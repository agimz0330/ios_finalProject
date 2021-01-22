//
//  igResponse.swift
//  finalProject
//
//  Created by User07 on 2021/1/5.
//

// not use
import Foundation

// IG的資料格式
struct igResponse: Codable{
    
    let graphql: Graphql
    struct Graphql: Codable {
        
        let user: User
        struct User: Codable {
            
            let biography: String // 自我介紹
            let profile_pic_url_hd: String // 頭像
            let username: String // 使用者帳號
            let full_name: String // 使用者名稱
            let external_url: String
            let is_verified: Bool

            let edge_followed_by: Edge_followed_by
            struct Edge_followed_by:Codable {
                let count: Int // 粉絲人數
            }

            // 圖片貼文資料(只取得12筆資料)
            let edge_owner_to_timeline_media: Edge_owner_to_timeline_media
            struct Edge_owner_to_timeline_media: Codable {

                let count: Int // 總貼文數

                let page_info: Page_info
                struct Page_info: Codable{
                    let has_next_page: Bool
                    let end_cursor: String
                }

                let edges: [Edges]
                struct Edges: Codable {

                    var node: Node
                    struct Node: Codable {

                        let __typename: String
                        let shortcode: String
//                        let display_url: URL
                        let display_url: String

                        let edge_media_to_caption: Edge_media_to_caption // 圖片貼文標題
                        struct Edge_media_to_caption: Codable {

                            let edges: [Edges]
                            struct Edges: Codable {

                                var node: Node
                                struct Node: Codable {
                                    var text: String
                                }
                            }
                        }

                        let edge_media_to_comment: Edge_media_to_comment // 圖片貼文留言數
                        struct Edge_media_to_comment: Codable {
                            let count: Int
                        }

                        let edge_liked_by: Edge_liked_by // 圖片貼文按讚數
                        struct Edge_liked_by: Codable {
                            let count: Int
                        }

                        let taken_at_timestamp: Date // 圖片貼文時間
                        let thumbnail_src: String // 縮圖
                    }
                }
            }

            let edge_felix_video_timeline: Edge_felix_video_timeline // 影片貼文資料
            struct Edge_felix_video_timeline: Codable {

                let edges: [Edges]
                struct Edges: Codable {

                    var node: Node
                    struct Node: Codable {
                        let display_url: String
                        let video_url: URL
                    }
                }
            }

            let edge_follow: Edge_follow
            struct Edge_follow: Codable {
                let count: Int // 追蹤者數量
            }
        }
    }
}
