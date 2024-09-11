#include "gameengine.h"
#include <QDebug>

GameEngine::GameEngine(QObject *parent) : QObject(parent)
{
}

void GameEngine::startGame()
{
    qDebug() << "Game started!";
}
