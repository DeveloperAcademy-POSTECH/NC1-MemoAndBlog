//
//  ContentView.swift
//  NC1v2
//
//  Created by 임성균 on 2022/04/27.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수. @AppStorage에 저장되어 앱 종료 후에도 유지됨.
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    // NC1v2App으로부터 CoreData Context 전달 받기. 이 데이터를 사용해서 데이터 저장, 수정, 삭제 등을 진행하게 됨.
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        TabBarView()
            // CoreData Context 전달.
            .environment(\.managedObjectContext, viewContext)
        
            // 앱 최초 구동 시 OnboardingTabView 띄우기
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
