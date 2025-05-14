// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI

@main
struct SupaApp: App {
    @State private var networkViewModel = NetworkViewModel()
    @State private var databaseConnectorViewModel = DatabaseConnectorViewModel()
    
    @State private var messagesViewModel = MessagesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkViewModel)
                .environment(databaseConnectorViewModel)
                .environment(messagesViewModel)
        }
    }
}
