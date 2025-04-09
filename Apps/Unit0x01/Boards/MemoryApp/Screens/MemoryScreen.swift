// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct MemoryScreen: View {
    var body: some View {
        CblScreen(title: "Memory", image: "memory_background") {
        //ZStack {
//            Image("memory_background")
//                .resizable()
//                //.scaledToFill()
//                .opacity(0.2)
//                .ignoresSafeArea()
            VStack(spacing:0) {
                //Divider()
                //HeaderText(text: "Memory")
                //    .padding(.bottom, 20)
                Spacer()
                MemoryCardGameView()
                Spacer()
            }
            
        }
    }
}

struct MemoryCardGameView: View {
    @Environment(MemoryViewModel.self) private var game

    private let emojis = ["🍎", "🍌", "🍓", "🍇", "🍉", "🍍", "🥝", "🍒"]
    //@State private var cards: [Card] = []
    @State private var firstFlipped: Int? = nil
    @State private var matchedPairs = 0

    var body: some View {
        VStack {

            Grid(horizontalSpacing: 8, verticalSpacing: 8) {
                ForEach(0..<4) { row in
                    GridRow {
                        ForEach(0..<4) { col in
                            let index = row * 4 + col
                            if index < game.cards.count {
                                CardView(card: game.cards[index])
                                    .onTapGesture {
                                        flipCard(at: index)
                                    }
                            } else {
                                Color.clear.frame(width: 60, height: 80)
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
        .onAppear(perform: resetGame)
    }

    private func flipCard(at index: Int) {
        guard !game.cards[index].isMatched && !game.cards[index].isFaceUp else { return }

        game.cards[index].isFaceUp = true

        if let first = firstFlipped {
            if game.cards[first].emoji == game.cards[index].emoji {
                game.cards[first].isMatched = true
                game.cards[index].isMatched = true
                matchedPairs += 1
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    game.cards[first].isFaceUp = false
                    game.cards[index].isFaceUp = false
                }
            }
            firstFlipped = nil
        } else {
            firstFlipped = index
        }
    }

    private func resetGame() {
        let paired = (emojis + emojis).shuffled()
        game.cards = paired.map { Card(emoji: $0) }
        firstFlipped = nil
        matchedPairs = 0
    }
}

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(CblTheme.light, lineWidth: 2)
                    )
                    .frame(width: 60, height: 80)
                Text(card.emoji)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(CblTheme.medium)
                    .frame(width: 60, height: 80)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: card.isFaceUp)
    }
}
