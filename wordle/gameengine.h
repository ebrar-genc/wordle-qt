#ifndef GAMEENGINE_H
#define GAMEENGINE_H

#include <QObject>
#include <QDebug>

class GameEngine : public QObject
{
    Q_OBJECT
public:
    explicit GameEngine(QObject *parent = nullptr);

    Q_INVOKABLE void startGame(); // QML'den çağrılabilir fonksiyon

signals:
    void gameStarted();

};

#endif // GAMEENGINE_H
