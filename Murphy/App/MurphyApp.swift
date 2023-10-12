//
//  MurphyApp.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import SwiftUI

@main
struct MurphyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
