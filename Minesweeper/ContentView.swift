import SwiftUI

struct ContentView: View {
    @StateObject private var game = Minesweeper(rows: 9, cols: 9, mineCount: 10)
    @State private var hasClicked = false
    @State private var revealed: [[Bool]] = Array(repeating: Array(repeating: false, count: 9),count: 9)


    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<game.rows, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<game.cols, id: \.self) { col in
                        let pos = Position(row: row, col: col)
                        Button {
                            if !hasClicked {
                                game.placeMines(excluding: pos)
                                hasClicked = true
                            }
                            revealed[row][col]=true
                        } label: {
                            Text(displaySymbol(for: pos))
                                .frame(width: 32, height: 32)
                                .background(Color.gray.opacity(0.3))
                                .border(Color.black)
                        }
                    }
                }
            }
        }
        .padding()
    }
    private func displaySymbol(for position: Position) -> String {
        if revealed[position.row][position.col] {
            return game.isMine(at: position) ? "💣" : "😀"
        }
        else {
            return ""
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
