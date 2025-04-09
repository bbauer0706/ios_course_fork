// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct ConnectFourScreen: View {
    
    var body: some View {
        CblScreen(title: "Connect Four", image: "lego_background") {
        //ZStack {
//            Image("lego_background")
//                .resizable()
//            //.scaledToFill()
//                .opacity(0.2)
//                .ignoresSafeArea()
            VStack(spacing:0) {
                //Divider()
                //HeaderText(text: "Connect Four")
                //    .padding(.bottom, 20)
                ConnectFourView()
                Spacer()
            }
        }
    }
}

struct ConnectFourView: View {
    let rows = 6
    let columns = 7
    
    // no board model here, can you provide one?
    
    @State var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 7), count: 6)
    @State var currentPlayer: Player = .red
    @State var winner: Player? = nil
    
    var body: some View {
        VStack {
            //Text(winnerText)
            //    .font(.title)
            //    .padding()
            
            Text(winnerText)
                .font(.title3)
                .foregroundColor(CblTheme.light)
                .frame(maxWidth: .infinity).background(CblTheme.dark.opacity(0.9))
                .border(CblTheme.light)
                .padding()
            
            Grid(horizontalSpacing: 4, verticalSpacing: 4) {
                ForEach(0..<rows, id: \.self) { row in
                    GridRow {
                        ForEach(0..<columns, id: \.self) { column in
                            Circle()
                                .fill(colorFor(row: row, column: column))
                                .frame(width: 40, height: 40)
                                .onTapGesture {
                                    dropDisc(in: column)
                                }
                        }
                    }
                }
            }
            .padding()
            
            Button("Reset") {
                resetGame()
            }
            .padding()
        }
    }
    
    private var winnerText: String {
        if let winner = winner {
            return "\(winner.rawValue.capitalized) wins!"
        } else {
            return "\(currentPlayer.rawValue.capitalized)'s turn"
        }
    }
    
    private func dropDisc(in column: Int) {
        return dropDiscHint(in: column)
    }
    
    private func colorFor(row: Int, column: Int) -> Color {
        switch board[row][column] {
        case .red: return .red
        case .yellow: return .yellow
        case .none: return CblTheme.dark.opacity(0.7)
        }
    }
    
    private func resetGame() {
        board = Array(repeating: Array(repeating: nil, count: columns), count: rows)
        currentPlayer = .red
        winner = nil
    }
    
    
}

enum Player: String {
    case red, yellow
    
    mutating func toggle() {
        self = (self == .red) ? .yellow : .red
    }
}
