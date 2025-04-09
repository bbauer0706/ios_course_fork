// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct LandingScreen: View {
    @Environment(AppViewModel.self) private var appViewModel
    
    var body: some View {
        CblScreen(title: "Welcome Screen", image: "lego_background") {
            VStack(spacing:0) {
                Text("User: \(appViewModel.user)")
                    .padding()
                Spacer()
            }
        }
    }
}
