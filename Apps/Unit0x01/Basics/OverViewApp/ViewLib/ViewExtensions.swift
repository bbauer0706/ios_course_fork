// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

extension View {
    var asLine: some View {
        self.foregroundColor(CblTheme.light)
            .frame(maxWidth: .infinity).background(CblTheme.dark.opacity(0.9))
            .border(CblTheme.light)
    }
}
