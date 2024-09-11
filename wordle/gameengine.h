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
    explicit GameEngine(QObject *parent = nullptr);

    Q_INVOKABLE void startGame(); // QML'den çağrılabilir fonksiyon
    Q_INVOKABLE void setLanguage(const QString &lang); // Dil ayarlarını yapar
    Q_INVOKABLE void setUnlimitedPlay(bool enabled); // Oyun modunu ayarlar

signals:
    void gameStarted();

private:
    FileManager fileManager;
    bool unlimitedPlay;
    QString currentLanguage;
};

#endif // GAMEENGINE_H
