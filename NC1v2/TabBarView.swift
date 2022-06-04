//
//  TabBarView.swift
//  NC1v2
//
//  Created by 임성균 on 2022/04/27.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var tabTagIndex = 0
    
    var body: some View {
        TabView(selection: $tabTagIndex) {
            EditingTabView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "note.text.badge.plus")
                    Text("쓰기")
                }
                .tag(0)
            
            ReadingTabView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "eyes")
                    Text("읽기")
                }
                .tag(1)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
