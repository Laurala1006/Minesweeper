import Foundation

struct Position: Hashable {
    let row: Int
    let col: Int
}

class Minesweeper: ObservableObject {
    let rows: Int
    let cols: Int
    let mineCount: Int

    @Published var minePositions: Set<Position> = []
    private var boardGenerated = false

    init(rows: Int, cols: Int, mineCount: Int) {
        self.rows = rows
        self.cols = cols
        self.mineCount = mineCount
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
}
