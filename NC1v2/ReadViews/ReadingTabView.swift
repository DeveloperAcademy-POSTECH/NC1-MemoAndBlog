//
//  WritingTabView.swift
//  NC1v2
//
//  Created by 임성균 on 2022/04/27.
//

import SwiftUI

struct ReadingTabView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    
    @FetchRequest(sortDescriptors: [ SortDescriptor(\.publishedDate, order: .reverse) ],
                  predicate: NSPredicate(format: "isPublished == %d", true))
    private var publishedArticles: FetchedResults<Article>
    
    @State var isUpdating: Bool = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(publishedArticles, id: \.id) { article in
                    NavigationLink {
                        ReadArticleView(isUpdating: $isUpdating, article: article)
                            .environment(\.managedObjectContext, viewContext)
                    } label: {
                        ReadCellView(article: article)
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    article.isPublished = false
                                    
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                } label: {
                                    Label("발행 취소", systemImage: "tray.and.arrow.down.fill")
                                }
                                .tint(.orange)
                            }
                    }
                }
                .onDelete(perform: { _ in
                })
                
            }
            .navigationTitle("읽기")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        addArticle()
//                    } label: {
//                        Image(systemName: "square.and.pencil")
//                    }
//                }
//            }
        }
    }
    
//
    
}

//struct WritingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        WritingTabView()
//    }
//}
