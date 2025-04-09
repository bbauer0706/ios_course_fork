// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct TicTacToeScreen: View {
    @Environment(TicTacToeViewModel.self) private var game
    @Environment(HighscoreViewModel.self) private var highscore
    
    var body: some View {
        CblScreen(title: "Board Games", image: "memory_backgrd") {
            VStack(spacing:0) {
                HighscoreView()
                TicTacToeView()
                
                HStack {
                    Spacer()
                    Button("Reset") { game.reset(); highscore.reset() }
                        .bold()
                    Spacer()
                    Button("+1") {
                        highscore.score += 1
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct HighscoreView: View {
    @Environment(HighscoreViewModel.self) private var highscore
    @Environment(TicTacToeViewModel.self) private var game
    
    var body: some View {
        Text("Player \(game.currentPlayer) [\(highscore.score)]")
            .font(.title3)
            .foregroundColor(CblTheme.light)
            .frame(maxWidth: .infinity).background(CblTheme.dark.opacity(0.9))
            .border(CblTheme.light)
            .padding()
    }
}

struct TicTacToeView: View {
    @Environment(TicTacToeViewModel.self) private var game
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<9, id: \.self) { index in
                ZStack {
                    Rectangle()
                        .foregroundColor(CblTheme.medium.opacity(0.8))
                        .frame(height: 120)
                    //.cornerRadius(10)
                        .border(CblTheme.light)
                    Text(game.board[index].rawValue)
                        .font(.system(size: 40))
                }
                .onTapGesture {
                    game.tap(at: index)
                }
            }
        }
        .padding()
    }
}
