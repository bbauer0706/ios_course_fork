// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct TicTacToeScreen: View {
    @Environment(TicTacToeViewModel.self) private var game
    @Environment(HighscoreViewModel.self) private var highscore
    
    var body: some View {
        CblScreen(title: "Board Games", image: "memory_backgrd") {

//        ZStack {
//            Image("street_board_game")
//                .resizable()
//                .scaledToFill()
//                .opacity(0.6)
//                .ignoresSafeArea()
            VStack(spacing:0) {
                //Divider()
                //HeaderText(text: "Tic Tac Toe")
                //    .padding(.bottom, 20)
                
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
                    //.foregroundColor(.black)
                        //.padding()
                    //.background(Color.orange.opacity(0.6))
                    //.cornerRadius(20)
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
//        ZStack {
//            Text("Player [\(highscore.score)]")
//                .font(.title3)
//                .foregroundColor(.orange)
//            HStack(spacing: 5) {
//                Spacer()
//            }
//        }
//            .frame(maxWidth: .infinity, maxHeight: 40)
//            .background(.black.opacity(0.5))
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
