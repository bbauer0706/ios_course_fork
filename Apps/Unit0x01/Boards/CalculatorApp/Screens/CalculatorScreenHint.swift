// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

extension CalculatorView {
    public func buttonTappedHint(_ label: String) {
        switch label {
        case "+", "-", "×", "÷":
            current = Double(display) ?? 0
            pendingOperation = label
            resetOnNextInput = true
            
        case "=":
            if let operation = pendingOperation, let input = Double(display) {
                switch operation {
                case "+": current += input
                case "-": current -= input
                case "×": current *= input
                case "÷": current /= input
                default: break
                }
                display = String(current)
                pendingOperation = nil
                resetOnNextInput = true
            }
            
        case ".":
            if !display.contains(".") {
                display += "."
            }
            
        default:
            if resetOnNextInput {
                display = label
                resetOnNextInput = false
            } else {
                display = (display == "0.0") ? label : display + label
            }
        }
    }

}
