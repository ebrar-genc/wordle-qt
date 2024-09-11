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
        emit gameWon();
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

//dailyword ile karşılaştırarak renk bilgisi dönme
QVariantList GameEngine::compareGuess(const QString &guess) {
    QVariantList result;

    //tekrar eden harfleri belirlemek için
    QVector<bool> dailyUsed(5, false);

    // doğru pozisyon kontrol
    for (int i = 0; i < 5; ++i) {
        if (guess[i] == dailyWord[i]) {
            result.append("green");
            dailyUsed[i] = true;
        } else {
            result.append("grey");
        }
    }

    // diğer pozisyonlar kontrol
    for (int i = 0; i < 5; ++i) {
        if (result[i] == "grey") { // Daha önce doğru pozisyon olarak işaretlenmemişse
            for (int j = 0; j < 5; ++j) {
                if (!dailyUsed[j] && guess[i] == dailyWord[j]) {
                    result[i] = "yellow";
                    dailyUsed[j] = true;
                    break;
                }
            }
        }
    }
    return result;
}
