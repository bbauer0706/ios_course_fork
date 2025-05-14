// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import Supabase

import CblUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            LoginScreen().tabItem {
                Label("Login", systemImage: "1.circle")
            }.tag(0)
            MessagesScreen().tabItem {
                Label("Messages", systemImage: "2.circle")
            }.tag(1)
        }
        .accentColor(colorScheme == .dark ? CblTheme.light : CblTheme.red)
        .onAppear { selectedTab = 0 }
    }
}
