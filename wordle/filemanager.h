#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QString>
#include <QObject>

class FileManager : public QObject
{
    Q_OBJECT

public:
    explicit FileManager(QObject *parent = nullptr);

    QString language() const;
    void setLanguage(const QString &lang);
    void setWordListFilePath(const QString &path);

    void setupDailyWord();

private:
    QString dailyWordFilePath;
    QString wordListFilePath;
    QString m_language;

    QString getRandomWordFromTxt();
    bool isWordUsed(const QString &word);
    void addUsedWord(const QString &word);
    void updateFilePath();
};

#endif // FILEMANAGER_H
