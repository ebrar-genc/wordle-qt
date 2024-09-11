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

    Q_INVOKABLE void startGame(); // QML'den çağrılabilir fonksiyon
    Q_INVOKABLE QString getDailyWord() const;



private:
    QString dailyWord;
    FileManager *fileManager;
};

#endif // GAMEENGINE_H
