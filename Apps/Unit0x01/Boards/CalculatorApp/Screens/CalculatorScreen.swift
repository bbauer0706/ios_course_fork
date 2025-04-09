// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct CalculatorScreen: View {
    
    var body: some View {
        CblScreen(title: "Calc", image: "lego_class_background") {
            VStack(spacing:0) {
                CalculatorView()
                Spacer()
            }
        }
    }
}

struct CalculatorView: View {
    @State var display = "0.0"                  // first or second op
    @State var current = 0.0                    // first op
    @State var pendingOperation: String? = nil  // hold the operation when entering the second op
    @State var resetOnNextInput = false         // clear before next input if true
    
    let buttons: [[String]] = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "×"],
        ["0", ".", "=", "÷"]
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text(display)
                .font(.system(size: 64))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { label in
                        Button(action: { self.buttonTapped(label) }) {
                            Text(label)
                                .font(.title)
                                .frame(width: 70, height: 70)
                            //.tint(Color.white)
                                .tint(CblTheme.light)
                            //.background(Color.blue.opacity(0.5))
                                .background(CblTheme.dark)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            
            Button("Clear") {
                clear()
            }
            .padding()
        }
        .padding()
    }
    
    private func buttonTapped(_ label: String) {
        buttonTappedHint(label)
    }
    
    private func clear() {
        display = "0.0"
        current = 0
        pendingOperation = nil
        resetOnNextInput = false
    }
}
