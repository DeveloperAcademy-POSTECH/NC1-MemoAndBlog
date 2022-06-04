//
//  EditArticleView.swift
//  NC1v2
//
//  Created by 임성균 on 2022/04/27.
//

import SwiftUI

struct ReadArticleView: View {
    // CoreData Context 전달받기.
    @Environment(\.managedObjectContext) var viewContext
    
    // EditingTabView 업데이트를 위한 isUpdating 값 전달받기.
    @Binding var isUpdating: Bool
    
    
    // EditThumbnailView 업데이트를 위한 article 값 전달받기.
    @ObservedObject var article: Article
    
    // TextEditor에 넣어주기 위한 임시 바인딩 값 설정
    @State var title: String = ""
    @State var content: String = ""
    @State private var comment: String = "댓글을 입력하세요"
    @State var isLiked: Bool = false
    
    //
//    enum FocusField: Hashable {
//        case field, non
//    }
//    @FocusState private var focusedField: FocusField?
    
    
    @State var isCommenting: Bool = false
    
    var body: some View {
        List {
            // 제목
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .frame(height: 60, alignment: .leading)
                .lineSpacing(10)
            
            // 본문
            VStack {
                HStack {
                    Text(content)
                        .frame(height: 400, alignment: .topLeading)
                        .lineSpacing(10)
                        .padding(.top)
                    Spacer()
                }
                
                HStack {
                    if isLiked {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                            .onTapGesture {
                                isLiked.toggle()
                            }
                        
                    } else {
                        Image(systemName: "heart")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .opacity(0.8)
                            .onTapGesture {
                                isLiked.toggle()
                            }
                        
                    }
                    Image(systemName: "message")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .opacity(0.8)
                        .padding(.leading, 7)
                        .onTapGesture {
                            isCommenting.toggle()
//                            focusedField = .field
                        }
                    
                    Spacer()
                    
                }
            }
            .padding(.bottom)
        }
        
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//
//                    HStack(alignment: .center) {
//                        Image(systemName: "person.circle.fill")
//                            .font(.title2)
//                            .foregroundColor(.gray)
//
//                        // 댓글 창
//                        TextEditor(text: $comment)
//                            .font(.title3)
//                            .foregroundColor(.gray)
////                            .focused($focusedField, equals: .field)
//
//                        Spacer()
//                        Image(systemName: "paperplane.fill")
//                            .font(.title2)
//                            .foregroundColor(.blue)
//                            .onTapGesture {
//                                isCommenting.toggle()
////                                focusedField = .non
//                            }
//                    }
//                    .padding(.horizontal, 3)
//
//            }
//        }
        
                .sheet(isPresented: $isCommenting, content: {
                    List {
                        HStack(alignment: .center) {
                            Image(systemName: "person.circle.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
        
                            // 댓글 창
                            TextEditor(text: $comment)
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "paperplane.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    isCommenting.toggle()
                                }
                        }
                        .padding(.horizontal, 3)
                    }
                })
        
        
        // article의 내용을 바인딩 변수에 할당
        .onAppear {
            title = article.title ?? "제목이 없어요"
            content = article.content ?? "내용이 없어요"
            isLiked = article.isLiked
        }
        
        // title이 변경될 때마다 article.title에 값을 다시 할당하고 저장
        .onChange(of: title) { newValue in
            article.title = title
            
            // CoreData에 변경내역 업데이트
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        // content가 변경될 때마다 article.content에 값을 다시 할당하고 저장
        .onChange(of: content) { newValue in
            article.content = content
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        // content가 변경될 때마다 article.content에 값을 다시 할당하고 저장
        .onChange(of: isLiked) { newValue in
            article.isLiked = isLiked
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        // EditArticleView가 닫힐 때 아래의 활동 수행
        // 1. 최종 수정일을 업데이트하고 저장
        // 2. EditingTabView 업데이트를 위해 isUpdating 변수를 변경
        .onDisappear {
            article.lastEditedDate = Date()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            isUpdating.toggle()
        }
    }
}

//struct EditArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditArticleView()
//    }
//}
