# Minesweeper Game
This is a simple implementation of the Minesweeper game using SwiftUI and Swift. The game features a mine layout and displays the result of either hitting a mine or successfully avoiding all mines.  

## Installation and Setup Guide

### System Requirements
- **macOS Version**: 10.15 (Catalina) or newer
- **Xcode Version**: 12.0 or newer

### Step 1: Clone the Project

To get started, clone the repository to your local machine using the following command:

```bash
git clone https://github.com/Laurala1006/Minesweeper.git
```
### Step 2: Open the Project
Navigate to the project directory in your terminal.  
Open the project file (.xcodeproj or .xcworkspace) in Xcode:

```bash
open Minesweeper.xcodeproj
```
### Step 3: Run the Project
In Xcode, select your desired simulator or connect your iOS device.  
Press `Cmd + R` to run the project.  

### Step 4: Start the Game
Once the game starts, click on the cells to begin the game.  
If you hit a mine, a "Game Over" alert will appear, and you can choose to restart.  
If you successfully avoid all mines, a "You Win!" alert will appear.  

## Project Structure
- `ContentView.swift`: Implements the game UI using SwiftUI and handles user interactions.
- `Position.swift`: Defines the position structure for grid coordinates and contains core game logic, including mine placement, game progression, and win/lose conditions.

## How to Play
1. The game board consists of a grid of cells.  
2. Each cell can either be revealed or hidden.  
3. Clicking on a hidden cell reveals its content:  
    If the cell contains a mine, you lose the game.  
    If the cell is empty, it is revealed and the game continues.  
4. The objective is to reveal all cells that do not contain mines.

Note:  
You can also download the entire repository and use Xcode to open and run the project as an alternative method.

