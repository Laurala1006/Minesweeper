import Foundation

struct Position: Hashable {
    let row: Int
    let col: Int
}

enum CellState {
    case hidden
    case revealed
}

class Minesweeper: ObservableObject {
    let rows: Int
    let cols: Int
    let mineCount: Int

    @Published var minePositions: Set<Position> = []
    @Published var cellStates: [[CellState]]
    private var boardGenerated = false

    init(rows: Int, cols: Int, mineCount: Int) {
        self.rows = rows
        self.cols = cols
        self.mineCount = mineCount
        self.cellStates = Array(repeating: Array(repeating: .hidden, count: cols), count: rows)
    }

    func placeMines(excluding firstClick: Position) {
        guard !boardGenerated else { return }

        var allPositions: [Position] = []
        for row in 0..<rows {
            for col in 0..<cols {
                let pos = Position(row: row, col: col)
                if pos != firstClick {
                    allPositions.append(pos)
                }
            }
        }

        allPositions.shuffle()
        minePositions = Set(allPositions.prefix(mineCount))
        boardGenerated = true
    }

    func isMine(at position: Position) -> Bool {
        minePositions.contains(position)
    }
    
    func reveal(at pos: Position) {
            guard cellStates[pos.row][pos.col] == .hidden else { return }
            cellStates[pos.row][pos.col] = .revealed
        }

        func isRevealed(_ pos: Position) -> Bool {
            return cellStates[pos.row][pos.col] == .revealed
        }

        func checkWin() -> Bool {
            var count = 0
            for row in 0..<rows {
                for col in 0..<cols {
                    let pos = Position(row: row, col: col)
                    if cellStates[row][col] == .revealed && !minePositions.contains(pos) {
                        count += 1
                    }
                }
            }
            return count == (rows * cols - mineCount)
        }

        func reset() {
            minePositions = []
            boardGenerated = false
            cellStates = Array(repeating: Array(repeating: .hidden, count: cols), count: rows)
        }
}
