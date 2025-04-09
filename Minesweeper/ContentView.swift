import SwiftUI

struct ContentView: View {
    @StateObject private var game = Minesweeper(rows: 2, cols: 2, mineCount: 1)
    @State private var hasClicked = false
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
                            game.reveal(at: pos)
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
        if game.isRevealed(position) {
            return game.isMine(at: position) ? "💣" : "😀"
        } else {
            return ""
        }
    }
    private func restartGame(){
        game.reset()
        hasClicked = false
        isGameOver = false
        isGameWon = false
    }

    private func checkForWin() {
        if game.checkWin() {
            isGameWon = true
            showWinAlert = true
        }
    }

}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
