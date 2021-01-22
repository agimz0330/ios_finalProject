//
//  finalProjectApp.swift
//  finalProject
//
//  Created by User07 on 2021/1/5.
//

import SwiftUI
import FacebookCore

@main
struct finalProjectApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                })
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
