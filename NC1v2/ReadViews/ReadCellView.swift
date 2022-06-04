//
//  ReadThumbnailView.swift
//  NC1v2
//
//  Created by 임성균 on 2022/04/27.
//

import SwiftUI

struct ReadCellView: View {
    
    // article 값이 변경되면 Thumbnail도 수정되도록, article을 @ObservedObject로 받기.
    @ObservedObject var article: Article
    
    var body: some View {
        VStack {
            // profile, name of author
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                
                VStack(alignment: .leading) {
                    Text(article.author ?? "익명")
                        
                    
                    Text("발행일: \(formatLastEditedDate(article.lastEditedDate))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
            }
            .padding(.top, 10)
            
            // Title, Photo
            HStack {
                Text(article.title ?? "SwiftUI로 ImagePicker 만들기")
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontWeight(.regular)
                Spacer()
            }
            .padding(.top, 5)
            
            HStack {
                if article.isLiked {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                    
                } else {
                    Image(systemName: "heart")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .opacity(0.8)
                }
                
                Image(systemName: "bookmark")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .opacity(0.8)
                
                Spacer()
            }
            .padding(.top, 3)
            .padding(.bottom, 8)
            
            
        }
    }
    
    // 날짜 포매팅
    func formatLastEditedDate(_ lastEditedDate: Date?) -> String {
        
        guard let lastEditedDate = lastEditedDate else {
            return "No information"
        }
        
        let formatter = RelativeDateTimeFormatter()
        let components = Calendar.current.dateComponents(
                    [.day, .year, .month, .minute, .second],
                    from: Date(),
                    to: lastEditedDate)
        return formatter.localizedString(from: components)
    }
}

//struct ArticleThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleThumbnailView()
//    }
//}
