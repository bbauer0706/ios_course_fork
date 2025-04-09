// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct LandingScreen: View {
    @Environment(TicTacToeViewModel.self) private var game
    @Binding var selection: Int
    
    var body: some View {
        CblScreen(title: "Board Games", image: "memory_backgrd") {
            VStack(spacing: 5) {
                VStack {
                    Text("Welcome to the Board Game Collection!")
                        .font(.title2)
                        .padding()
                    Button("Start a new game") {
                        game.reset()
                        selection = 1
                    }
                        .padding()
                }
                //Spacer()
            }.padding()
        }
    }
}
