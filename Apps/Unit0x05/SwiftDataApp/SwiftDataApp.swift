// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 .modelContainer(for:) is the SwiftData equivalent of Core Data’s NSPersistentContainer
 
 Under the hood, it:
 - Analyzes your @Model types (e.g., Book, Author) and builds a schema.
 - Creates a persistent store, backed by SQLite (by default).
 - Injects the container into the environment, so:
    @Environment(\.modelContext) works
    @Query can fetch models
    modelContext.insert(), delete(), etc., work seamlessly
 */

import SwiftUI

@main
struct SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Author.self, Book.self])
    }
}
