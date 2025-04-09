// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            LayoutsScreen().tabItem {
                Label("Layouts", systemImage: "uiwindow.split.2x1")
            }.tag(0)
            TextsScreen().tabItem {
                Label("Texts", systemImage: "textformat.size")
            }.tag(1)
            ElementsScreen().tabItem {
                Label("Elements", systemImage: "slider.horizontal.below.square.filled.and.square")
            }.tag(2)
            ImagesScreen().tabItem {
                Label("Images", systemImage: "photo.artframe")
            }.tag(3)
            ArrayScreen().tabItem {
                Label("Grids", systemImage: "square.grid.4x3.fill")
            }.tag(4)
        }
        .accentColor(colorScheme == .dark ? CblTheme.light : CblTheme.red)
        .onAppear { selectedTab = 0 }
    }
}
