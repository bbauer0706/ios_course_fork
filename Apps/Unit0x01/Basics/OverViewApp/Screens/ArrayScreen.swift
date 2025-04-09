// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI
import CblUI

struct ArrayScreen: View {
    var body: some View {
        CblScreen(title: "Layouts", image: "Background") {
            VStack(spacing: 5) {
                //Divider()
                GridsView()
                Spacer()
            }.padding()
        }
    }
}

struct GridCell: View {
    let index: Int
    @Binding var board: [Int]

    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(CblTheme.dark)
            Text("[\(index)]: \(board[index])")
                
                .foregroundColor(CblTheme.light)
        }
        // .background(Color.pink)      only the background behind the rounded rect. (corners)
        .onTapGesture {
            board[index] += 1
            //let n = (Int(board[index]) ?? 0)+1
            //board[index] = String(n)
        }
        .padding(3)
        .frame(width: width, height: height)
    }
}

struct BoardLayout {
    let rows:Int
    let cols:Int
    let cgSize: CGSize
    
    enum Area {
        case area1, area2, area3, area4
        
        var percentage: CGFloat {
            switch self {
            case .area1: return 20
            case .area2: return 40
            case .area3: return 25
            case .area4: return 15
            }
        }
        
    }
    
    func height(of area:Area) -> CGFloat { cgSize.height * area.percentage / 100.0 }
    func width(of area:Area) -> CGFloat { cgSize.width }
    func tileHeight(of area:Area) -> CGFloat { height(of: area) / CGFloat(rows) }
    func tileWidth(of area:Area) -> CGFloat { width(of: area) / CGFloat(cols) }
}

struct GridsView: View {
    let rows: Int
    let cols: Int
    var tiles: Int {rows * cols}

    init() {
        rows = 3
        cols = 4
        board = Array(repeating: 0, count: rows * cols)
        columns = Array(repeating: GridItem(.flexible(),spacing:0), count: cols)
    }
    
    @State var board: [Int]
    let columns: Array<GridItem>

    var body: some View {
        // something like full size box
        Color.clear.frame(maxWidth: .infinity, maxHeight: .infinity).overlay(
            // just take the size inside
            GeometryReader { geometry in
                let layout = BoardLayout(rows:rows, cols:cols, cgSize:geometry.size)
                VStack(spacing: 0) {
                    // area 1
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(0..<tiles, id:\.self) { index in
                            GridCell(index: index, board: $board,
                                     width: layout.tileWidth(of: .area1),
                                     height: layout.tileHeight(of: .area1))
                        }
                    }
                    // .frame(height: layout.height(of: .area1))
                    .background(Color.pink.opacity(0.3))
                    
                    // area 2
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { i in
                            HStack(spacing: 0){
                                ForEach(0..<cols, id: \.self) { j in
                                    let index = i*cols + j
                                    GridCell(index: index, board: $board,
                                             width: layout.tileWidth(of: .area2),
                                             height: layout.tileHeight(of: .area2))
                                }
                            }
                            
                        }
                    }
                    // .frame(height: layout.height(of: .area2))
                    .background(Color.pink.opacity(0.6))
                    
                    // area 3
                    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                        ForEach(0..<rows, id: \.self) { i in
                            GridRow {
                                ForEach(0..<cols, id: \.self) { j in
                                    let index = i*cols + j
                                    GridCell(index: index, board: $board,
                                             width: layout.tileWidth(of: .area3),
                                             height: layout.tileHeight(of: .area3))
                                }
                            }
                        }
                    }
                    // .frame(height: layout.height(of: .area3))
                    .background(Color.pink.opacity(0.3))
                    
                    // area 4
                    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                        GridRow(alignment: .bottom) {
                            Text("Bob").font(.caption).border(CblTheme.light)
                                .gridColumnAlignment(.trailing)
                            Text("Needs to fill in data").border(CblTheme.light)
                                .gridColumnAlignment(.leading)
                                
                        }
                        GridRow(alignment: .top) {
                            Text("Alice").border(CblTheme.light)
                            Text("(offline)").font(.caption).border(CblTheme.light)
                        }
                    }
                    .frame(width:layout.width(of: .area4), height: layout.height(of: .area4))
                    .background(Color.pink.opacity(0.6))
                }
            }
        )
    }
}

/*
 board
  - @State is for data that changes and affects the UI.
  — board is dynamic, it changes when a user taps a cell, so marking it with @State triggers a UI update when the array is mutated.

 columns
  - is just a static layout configuration. It doesn’t change during the lifecycle of the view. There’s no need for SwiftUI to track it for invalidation and redraws.
  - Marking it with @State would be unnecessary overhead.
 
 grids
  - LazyVGrid pros:
     - Clean layout for grid-based UIs like a board game.
     - Flexibility: just define columns, and it figures out rows automatically.
     - Lazy rendering: only renders cells that are visible (handy if your grid was 100x100 instead of 3x3).
 
  - Nested ForEach
     - less elegant—especially for bigger grids. And it’s not lazy.

  - new Grid und GridRow
     - a bit more flexible for things like headers, see MemoryApp
 
 ids
  - When you use ForEach, SwiftUI needs a way to uniquely identify each item in the collection so it can:
     - Track changes efficiently
     - Animate updates
  - Looping over simple types like Int, String, etc., don’t come with a built-in identity, so you have to tell SwiftUI how to uniquely identify each item -> hence 'id: \.self'
  -  Implementing 'Identifiable' with a member 'id' is also sufficient.
 
 key path
   - A key path in Swift is a type-safe, compiler-checked reference to a property, like a pointer to a property.
   - \Type.property is a key path.
   - \.self is a special case where you’re telling Swift: Use the value itself as the identifier.
 */
