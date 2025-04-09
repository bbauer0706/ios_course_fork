// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct ContentScreen: View {
    @Environment(AppViewModel.self) private var appViewModel
    
    var body: some View {
        CblScreen(title: "Content Screen", image: "lego_background") {
            VStack(spacing:0) {
                Text("Score: \(appViewModel.score)")
                    .padding()
                Spacer()
            }
        }
    }
}
