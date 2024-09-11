#include "gameengine.h"

GameEngine::GameEngine(QObject *parent)
    : QObject(parent){}

// Oyun başlatma fonksiyonu
void GameEngine::startGame() {
    qDebug() << "Game started!";
}
