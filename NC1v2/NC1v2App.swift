//
//  NC1v2App.swift
//  NC1v2
//
//  Created by 임성균 on 2022/04/27.
//

import SwiftUI

@main
struct NC1v2App: App {
    // CoreData Controller
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Deliver CoreData context.
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
