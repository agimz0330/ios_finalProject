//
//  finalProjectApp.swift
//  finalProject
//
//  Created by User07 on 2021/1/5.
//

import SwiftUI

@main
struct finalProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
