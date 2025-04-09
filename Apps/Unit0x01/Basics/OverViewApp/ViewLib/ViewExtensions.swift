// (C) 2024 A.Voß, a.voss@fh-aachen.de, ios@codebasedlearning.dev

import SwiftUI
import CblUI

extension View {
    var asLine: some View {
        //self.frame(maxWidth: .infinity).background(.orange.opacity(0.8))
        
        self.foregroundColor(CblTheme.light)
            .frame(maxWidth: .infinity).background(CblTheme.dark.opacity(0.9))
            .border(CblTheme.light)
    }
}
