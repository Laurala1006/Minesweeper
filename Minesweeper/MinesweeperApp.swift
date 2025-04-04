//
//  MinesweeperApp.swift
//  Minesweeper
//
//  Created by 吳育臻 on 2025/4/4.
//

import SwiftUI

@main
struct MinesweeperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
