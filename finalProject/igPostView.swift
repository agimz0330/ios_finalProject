//
//  igPostView.swift
//  finalProject
//
//  Created by User08 on 2021/1/10.
//

import SwiftUI
import SDWebImageSwiftUI

struct igPostView: View {
    var postsData: [instagramPostData]
    var personData: instagramProfileData
    var currentPost: Int
        
    var body: some View {
        let MyYellow:Color = Color(red: 253/255, green: 251/255, blue: 239/255)
        
        ZStack{
            MyYellow
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical){
                let columns = [GridItem()]
                
                LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]) {
                    Section(header: sectionHeaderView(personData: personData)){
                        ForEach(currentPost ..< postsData.count) { (index) in
//                            PostDetailView(post: posts[index])
                            
                            // GrapghImage
//                            if postsData[index].__typename == "GraphImage"{
                                WebImage(url: URL(string: postsData[index].display_url)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:UIScreen.main.bounds.width)
//                            }
//                            // GraphVideo
//                            else if postsData[index].__typename == "GraphVideo"{
//                                VStack{
//                                    ZStack{
//                                        VideoPlayer(player: $player)
//                                        if self.showcontrols{
//                                            Controls(player: self.$player, isplaying: self.$isplaying, pannel: self.$showcontrols,value: self.$value)
//                                        }
//                                    }
//                                    .frame(height: UIScreen.main.bounds.height / 3.5)
//                                    .onTapGesture {
//                                        self.showcontrols = true
//                                    }
//                                }
//                                .background(Color.black.edgesIgnoringSafeArea(.all))
//                                .onAppear {
//                                    self.player.play()
//                                    self.isplaying = true
//                                }
//                            }
//                            // GraphSideCar
//                            else if postsData[index].__typename == "GraphSideCar"{
//                                WebImage(url: URL(string: postsData[index].display_url)!)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width:UIScreen.main.bounds.width)
//                            }
                            
                            HStack{
                                VStack(alignment: .leading, spacing: 5){
                                    HStack{
                                        Image(systemName: "heart")
                                        Text("\(postsData[index].liked)個讚")
                                            .fontWeight(.bold)
                                            .font(.system(size: 15))
                                    }
                                    Text("\(postsData[index].text)")
                                        .font(.system(size: 15))
                                    Text("\(postsData[index].comment)則留言")
                                        .foregroundColor(Color(.gray))
                                        .font(.system(size: 15))
                                }
                                Spacer()
                            }.padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationTitle("貼文")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct igPostView_Previews: PreviewProvider {
    static var previews: some View {
        igPostView(postsData: [instagramPostData(display_url: "",
                                                text: "no. 0",
                                                comment: 0,
                                                liked: 0,
                                                __typename: "",
                                                shortcode: "",
                                                thumbnail_src: "")],
                   personData: instagramProfileData(profile_pic_url_hd: "",
                                                    username: "",
                                                    is_verified: true,
                                                    edge_followed_by: 0,
                                                    edge_follow: 0,
                                                    full_name: "",
                                                    biography: "",
                                                    external_url: "",
                                                    edge_owner_to_timeline_media_postcount: 0),
                   currentPost: 0)
    }
}

struct sectionHeaderView: View {
    var personData: instagramProfileData
    
    var body: some View {
        let MyGreen:Color = Color(red: 191/255, green: 224/255, blue: 235/255)
        let MyBlue:Color = Color(red: 57/255, green: 67/255, blue: 92/255)
        let MyYellow:Color = Color(red: 253/255, green: 251/255, blue: 239/255)
        
        ZStack{
            MyYellow
            HStack(alignment: .center, spacing: 10){
                ZStack{
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [MyBlue, MyGreen]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                        .frame(width:UIScreen.main.bounds.width/10+3,height:UIScreen.main.bounds.width/10+3)
                    WebImage(url: URL(string: personData.profile_pic_url_hd)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/10,height: UIScreen.main.bounds.width/10)
                        .cornerRadius(UIScreen.main.bounds.width/10)
                }
                HStack(alignment: .center, spacing: 5){
                    Text(personData.username)
                        .fontWeight(.bold)
                        .font(.system(size: 15))
                    if personData.is_verified == true{
                        Image("verified")
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                    }
                }
                Spacer()
            }.padding()
        }
    }
}
