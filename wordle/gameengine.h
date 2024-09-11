#ifndef GAMEENGINE_H
#define GAMEENGINE_H

#include <QObject>
#include <QDebug>
#include <QString>
#include "filemanager.h"

class GameEngine : public QObject
{
    Q_OBJECT
public:
    explicit GameEngine(QObject *parent = nullptr, FileManager *fileManager = nullptr);

     // QML'den çağrılabilir fonksiyonlar
    Q_INVOKABLE void startGame();
    Q_INVOKABLE QString getDailyWord() const;
    Q_INVOKABLE bool checkGuess(const QString &guess);

signals:
    void gameWon();
    void gameOver();

private:
    QString dailyWord;
    FileManager *fileManager;
    int guessCount;

    void endGame(bool won);

};

#endif // GAMEENGINE_H
