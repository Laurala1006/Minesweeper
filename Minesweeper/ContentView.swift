import SwiftUI

struct ContentView: View {
    @State private var game = Minesweeper(rows: 2, cols: 2, mineCount: 1)
    @State private var hasClicked = false
    @State private var revealed: [[Bool]] = Array(repeating: Array(repeating: false, count: 9),count: 9)
    @State private var isGameOver = false
    @State private var isGameWon = false
    @State private var showGameOverAlert = false
    @State private var showWinAlert = false

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
                            if game.isMine(at: pos){
                                isGameOver = true
                                showGameOverAlert = true
                            }
                            else{
                                checkForWin()
                            }
                        } label: {
                            Text(displaySymbol(for: pos))
                                .frame(width: 32, height: 32)
                                .background(Color.gray.opacity(0.3))
                                .border(Color.black)
                        }
                        .disabled(isGameOver)
                    }
                }
            }
        }
        .padding()
        .alert("💥 Game Over", isPresented: $showGameOverAlert) {
            Button("重新開始", role: .destructive) {
                restartGame()
            }
            Button("取消", role: .cancel) {}
        } message: {
            Text("你踩到地雷了！")
        }
        .alert("🎉 You Win!", isPresented: $showWinAlert) {
            Button("重新開始") {
                restartGame()
            }
        } message: {
            Text("你成功避開了所有地雷！")
        }

    }
    private func displaySymbol(for position: Position) -> String {
        if revealed[position.row][position.col] {
            return game.isMine(at: position) ? "💣" : "😀"
        }
        else {
            return ""
        }
    }
    private func restartGame(){
        game = Minesweeper(rows: 2, cols: 2, mineCount: 1) // 重新初始化遊戲物件
        hasClicked = false
        revealed = Array(repeating: Array(repeating: false, count: 9), count: 9)
        isGameOver = false
    }
    private func checkForWin() {
        var revealedCount = 0
        for row in 0..<game.rows {
            for col in 0..<game.cols {
                if revealed[row][col] {
                    revealedCount += 1
                }
            }
        }
        if revealedCount == game.rows * game.cols - game.mineCount {
            isGameWon = true
            showWinAlert = true
        }
    }

}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
