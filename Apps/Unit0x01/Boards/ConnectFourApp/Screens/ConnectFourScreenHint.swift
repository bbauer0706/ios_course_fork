// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

extension ConnectFourView {
    func dropDiscHint(in column: Int) {
        guard winner == nil else { return }
        for row in (0..<rows).reversed() {
            if board[row][column] == nil {
                board[row][column] = currentPlayer
                if checkWin(row: row, column: column, player: currentPlayer) {
                    winner = currentPlayer
                } else {
                    currentPlayer.toggle()
                }
                break
            }
        }
    }
    private func checkWin(row: Int, column: Int, player: Player) -> Bool {
        let directions = [(0,1), (1,0), (1,1), (1,-1)]
        for (dx, dy) in directions {
            var count = 1
            count += countDirection(row: row, column: column, dx: dx, dy: dy, player: player)
            count += countDirection(row: row, column: column, dx: -dx, dy: -dy, player: player)
            if count >= 4 { return true }
        }
        return false
    }
    private func countDirection(row: Int, column: Int, dx: Int, dy: Int, player: Player) -> Int {
        var x = row + dx
        var y = column + dy
        var count = 0
        while x >= 0 && x < rows && y >= 0 && y < columns && board[x][y] == player {
            count += 1
            x += dx
            y += dy
        }
        return count
    }
}
