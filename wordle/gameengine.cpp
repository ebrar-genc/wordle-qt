#include "gameengine.h"

GameEngine::GameEngine(QObject *parent, FileManager *fileManager)
    : QObject(parent), fileManager(fileManager) {
    if (!fileManager) {
        qDebug() << "FileManager pointer is null!";
    } else {
        qDebug() << "FileManager successfully assigned.";
    }
}

void GameEngine::startGame() {
    qDebug() << "Play button is clicked";
    if (fileManager) {
        dailyWord = fileManager->getDailyWord();
        qDebug() << "Game started with daily word:" << dailyWord;
    } else {
        qDebug() << "FileManager is not set!";
    }
}

QString GameEngine::getDailyWord() const {
    return dailyWord;
}

bool GameEngine::checkGuess(const QString &guess) {
    guessCount++;
    if (guess == dailyWord) {
        qDebug() << "Correct guess on attempt:" << guessCount;
        endGame(true);
        return true;
    }

    if (guessCount >= 6) {
        qDebug() << "All attempts used, game over.";
        endGame(false);
    }
    return false;
}

void GameEngine::endGame(bool won) {
    if (won) {
        emit gameWon();
    } else {
        emit gameOver();
    }
}
