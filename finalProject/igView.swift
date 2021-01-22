//
//  igView.swift
//  finalProject
//
//  Created by User08 on 2021/1/9.
//

import SwiftUI
// packages from
// https://github.com/SDWebImage/SDWebImageSwiftUI
import SDWebImageSwiftUI

struct igView: View {
    @ObservedObject var posts = getIGPostData()
    @ObservedObject var personInfo = getIGPersonData()
    
    var body: some View {
        let MyYellow:Color = Color(red: 253/255, green: 251/255, blue: 239/255)
//        let MyGreen:Color = Color(red: 191/255, green: 224/255, blue: 235/255)
        let MyBlue:Color = Color(red: 57/255, green: 67/255, blue: 92/255)
        
        NavigationView{
            ZStack{
                MyYellow // 背景色
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    personalInfoView(personInfo: personInfo.igPersonData) // 個人資料
                    
                    ScrollView(.vertical){
                        let columns = [GridItem(), GridItem(), GridItem()] // 分三行
                        LazyVGrid(columns: columns) {
                            
                            ForEach(posts.igPostData.indices) { (index) in
                                NavigationLink(destination: igPostView(postsData: posts.igPostData, personData: personInfo.igPersonData, currentPost: index)){
                                    
                                    VStack(alignment: .leading) {
                                        WebImage(url: URL(string: posts.igPostData[index].thumbnail_src)!)
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:UIScreen.main.bounds.width/3.5)
                                        HStack{
                                            Text("\(posts.igPostData[index].text)")
                                                .font(.custom("", size: 10))
                                                .foregroundColor(MyBlue)
                                        }
                                        Spacer()
                                    }
                                }
                                
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct igView_Previews: PreviewProvider {
    static var previews: some View {
        igView()
    }
}

class getIGPersonData: ObservableObject { // 取得個人資料
    @Published var igPersonData = instagramProfileData(profile_pic_url_hd: "",
                                                       username: "",
                                                       is_verified: false,
                                                       edge_followed_by: 0,
                                                       edge_follow: 0,
                                                       full_name: "",
                                                       biography: "",
                                                       external_url: "",
                                                       edge_owner_to_timeline_media_postcount: 0)
    
    init(){
        let url = Bundle.main.url(forResource: "igTest", withExtension: "json")! // (test)
        //if let urlStr = "https://www.instagram.com/nobodysdaily/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), // 某人的 IG API
           //let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url){(data, response, err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                if let data = data, let content = String(data: data, encoding: .utf8){
                    print(content)
                }
                
                if let data = data,
                   let json = try? decoder.decode(igResponse.self, from: data){
                    
                    let profile_pic_url_hd = json.graphql.user.profile_pic_url_hd
                    let username = json.graphql.user.username
                    let is_verified = json.graphql.user.is_verified
                    let edge_followed_by = json.graphql.user.edge_followed_by.count
                    let edge_follow = json.graphql.user.edge_follow.count
                    let full_name = json.graphql.user.full_name
                    let biography = json.graphql.user.biography
                    let external_url = json.graphql.user.external_url
                    let edge_owner_to_timeline_media_postcount = json.graphql.user.edge_owner_to_timeline_media.count
                    
                    DispatchQueue.main.async {
                        self.igPersonData = instagramProfileData(profile_pic_url_hd: profile_pic_url_hd,
                                                                 username: username,
                                                                 is_verified: is_verified,
                                                                 edge_followed_by: edge_followed_by,
                                                                 edge_follow: edge_follow,
                                                                 full_name: full_name,
                                                                 biography: biography,
                                                                 external_url: external_url,
                                                                 edge_owner_to_timeline_media_postcount: edge_owner_to_timeline_media_postcount)
                    }
                }
            }.resume()
        //}
    }
}

class getIGPostData: ObservableObject { // 取得貼文
    @Published var igPostData = [instagramPostData]()
    
    init(){
        let url = Bundle.main.url(forResource: "igTest", withExtension: "json")! // (test)
        //if let urlStr = "https://www.instagram.com/nobodysdaily/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), // 某人的 IG API
           //let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url){(data, response, err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                if let data = data,
                   let json = try? decoder.decode(igResponse.self, from: data){
                    
                    let edges = json.graphql.user.edge_owner_to_timeline_media.edges

                    for i in edges{
                        let display_url = i.node.display_url
                        let text = i.node.edge_media_to_caption.edges[0].node.text
                        let comment = i.node.edge_media_to_comment.count
                        let liked = i.node.edge_liked_by.count
                        let __typename = i.node.__typename
                        let shortcode = i.node.shortcode
                        let thumbnail_src = i.node.thumbnail_src

                        DispatchQueue.main.async {
                            self.igPostData.append(instagramPostData(display_url: display_url,
                                                               text: text,
                                                               comment: comment,
                                                               liked: liked,
                                                               __typename: __typename,
                                                               shortcode: shortcode,
                                                               thumbnail_src: thumbnail_src))
                        }
                    }
                }
            }.resume()
        //}
    }
}

struct personalInfoView: View {
    var personInfo: instagramProfileData
    
    var body: some View {
        HStack(alignment: .center, spacing: 25){ // 頭像 帳號名 貼文數 追蹤數 粉絲人數
            ZStack{ // 頭像
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 55/255, green: 177/255, blue: 75/255), Color.init(red: 244/255, green: 191/255, blue: 102/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                    .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.width/5+8.5)
                WebImage(url: URL(string: personInfo.profile_pic_url_hd)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
                    .cornerRadius(UIScreen.main.bounds.width/5)
            }
            VStack(alignment: .leading, spacing: 8){
                HStack(alignment: .center, spacing: 5){
                    Text(personInfo.username) // 帳號名
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    if personInfo.is_verified == true{ // 認證勾勾
                        Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                    }
                }
                HStack(spacing: 20){
                    VStack(alignment: .center){
                        Text("\(personInfo.edge_owner_to_timeline_media_postcount)")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        Text("貼文數")
                            .font(.system(size: 13))
                    }
                    VStack(alignment: .center){
                        Text("\(personInfo.edge_followed_by)")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        Text("粉絲人數")
                            .font(.system(size: 13))
                    }
                    VStack(alignment: .center){
                        Text("\(personInfo.edge_follow)")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        Text("追蹤中")
                            .font(.system(size: 13))
                    }
                    Spacer()
                }
            }
        }.padding(.horizontal, 20)
        //全名 自傳 外部連結
         VStack(alignment: .leading, spacing: 5){
            Text(personInfo.full_name)
                .fontWeight(.bold)
            Text(personInfo.biography)
                .font(.system(size: 13))
            Text(personInfo.external_url)
                .font(.system(size: 13))
                .foregroundColor(Color(red: 0.108, green: 0.586, blue: 0.881))
//                .onTapGesture {
//                    self.show.toggle()
//
//                }
//                .sheet(isPresented: self.$show){
//                    SafariView(url: URL(string: personInfo.external_url)!)
//                }
        }.padding(.horizontal, 20)
    }
}
