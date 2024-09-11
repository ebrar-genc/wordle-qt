#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QString>
#include <QObject>

class FileManager : public QObject
{
    Q_OBJECT

public:
    explicit FileManager(QObject *parent = nullptr);

    Q_INVOKABLE void setLanguage(const QString &lang); // QML'den çağrılabilir hale getirildi
    Q_INVOKABLE void setGameMode(const QString &gameMode); // QML'den çağrılabilir hale getirildi

    void setWordListFilePath(const QString &path);
    void setupDailyWord();

private:
    QString dailyWordFilePath;
    QString wordListFilePath;
    QString language;
    QString mode;

    QString getRandomWordFromTxt();
    bool isWordUsed(const QString &word);
    void addUsedWord(const QString &word);
    void updateFilePath();
};

#endif // FILEMANAGER_H
