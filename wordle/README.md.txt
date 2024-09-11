# Wordle Game in QML/C++ (Qt 5.14)

This is a Wordle-like game built using Qt Quick and C++. The player has 6 tries to guess a randomly chosen 5-letter word each day. The game provides feedback on the guessed words, indicating correct letters in the correct position (green), correct letters in the wrong position (yellow), and incorrect letters (grey).

## Features

- Daily random 5-letter word selection.
- Player can guess the word up to 6 times.
- Visual feedback with color coding to indicate correct and incorrect guesses.
- Congratulatory pop-up when the player guesses the word correctly.
- Language selection (English or Turkish) for the daily word.
- Game mode selection (Limited or Unlimited play).
- User interface built with Qt Quick, making it easy to extend and customize.

## Installation

1. Clone the repository
2. Install Qt 5.14
3. Open the Project
4. Build and run 


## Usage

-Select your preferred language (English or Turkish) from the main menu.
-Choose between Limited (one game per day) or Unlimited play mode.
-Start guessing the word using the on-screen keyboard.
-The game will provide feedback with the following color coding:
	Green: Correct letter in the correct position.
	Yellow: Correct letter in the wrong position.
	Grey: Incorrect letter.
-You win if you guess the word correctly within 6 tries. A congratulatory pop-up will appear.
-If you don't guess correctly within 6 tries, the game ends.


## Project Structure
main.qml: Main user interface and initial setup.
GameScreen.qml: Handles the game board and user interactions.
FileManager: Manages file operations, including daily word selection and dataset management.
GameEngine: Contains the core game logic, including word comparison and win/lose conditions.


![Home Page](Screenshots/homePage.png)

![Game Page](Screenshots/gamePage.png)

