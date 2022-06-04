//
//  EditingTabView.swift
//  NC1v2
//
//  Created by 임성균 on 2022/04/27.
//

import SwiftUI

struct EditingTabView: View {
    // CoreData Context 전달받기.
    @Environment(\.managedObjectContext) var viewContext
    
    // 뷰 업데이트가 필요할 때마다 .toggle()을 이용해 바꿔줌.
    @State var isUpdating: Bool = false
    
    // 발행되지 않은 포스트를, 최종 수정일 기준으로 불러오기
    @FetchRequest(sortDescriptors: [ SortDescriptor(\.lastEditedDate, order: .reverse) ],
                  predicate: NSPredicate(format: "isPublished == %d", false))
    private var articles: FetchedResults<Article>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(articles, id: \.id) { article in
                    NavigationLink {
                        EditArticleView(isUpdating: $isUpdating, article: article)
                            // CoreData Context 전달.
                            .environment(\.managedObjectContext, viewContext)
                    } label: {
                        EditCellView(article: article)
                        
                            // 오른쪽으로 스와이프해서 게시물 발행.
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    // 해당 게시물을 발행하고 현재 시각으로 발행일을 지정.
                                    article.isPublished = true
                                    article.publishedDate = Date()
                                    
                                    // CoreData에 변경 내역 업데이트.
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                    
                                    // 뷰 업데이트를 위한 @State 값 변경
                                    isUpdating.toggle()
                                } label: {
                                    Label("발행", systemImage: "tray.and.arrow.up.fill")
                                }
                                .tint(.purple)
                            }
                            // 왼쪽으로 스와이프해서 게시물 삭제.
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    // 해당 게시물 삭제.
                                    viewContext.delete(article)
                                    
                                    // CoreData에 변경 내역 업데이트.
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                    
                                    // 뷰 업데이트를 위한 @State 값 변경
                                    isUpdating.toggle()
                                } label: {
                                    Label("삭제", systemImage: "trash.fill")
                                }
                                .tint(.red)
                            }
                        
                    }
                }
                .onDelete(perform: { _ in
                })
                
            }
            .navigationTitle("쓰기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        addArticle()
                    } label: {
                        Image(systemName: "doc.badge.plus")
                    }
                }
            }
        }
    }
    
    private func addArticle() {
        let newArticle = Article(context: viewContext)
        newArticle.id = UUID()
        newArticle.author = "서담"
        newArticle.title = "놀라운 가이드"
        newArticle.content = "굉장한 개발 이야기"
        newArticle.isPublished = false
        newArticle.lastEditedDate = Date()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        isUpdating.toggle()
    }
    
    private func deleteArticle(offsets: IndexSet) {
        withAnimation {
            offsets.map { articles[$0] }
                .forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }

    }
}

//struct WritingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        WritingTabView()
//    }
//}
