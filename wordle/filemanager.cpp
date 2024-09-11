#include "filemanager.h"
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QRandomGenerator>
#include <QDebug>
#include <QStandardPaths>

FileManager::FileManager(QObject *parent)
    : QObject(parent){
}

/*QString FileManager::getLanguage() const {
    return language;
}

QString FileManager::getGameMode() const {
    return mode;
}
*/
void FileManager::setLanguage(const QString &lang) {
    Language = lang;
    updateFilePath(); // Dosya yollarını güncelle
    qDebug() << "Language set to:" << Language;
}

void FileManager::setGameMode(const QString &gameMode) {
    Mode = gameMode;
    qDebug() << "Game mode set to:" << Mode;
    setupDailyWord(); // Yeni günlük kelimeyi ayarla
    //mode işlemleri
}

// Dosya yollarını dil seçimine göre günceller
void FileManager::updateFilePath() {
    if (Language == "tr") {
        dailyWordFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\daily-word-tr.txt"; // Yerel dosya yolu
        wordListFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\5-letter-words-tr.txt"; // Yerel dosya yolu
    } else {
        dailyWordFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\daily-word-en.txt"; // Yerel dosya yolu
        wordListFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\5-letter-words-en.txt"; // Yerel dosya yolu
    }
    qDebug() << "Word List file path: " << wordListFilePath;
    qDebug() << "Daily word file path: " << dailyWordFilePath;
}

// Günlük kelimeyi ayarlar
void FileManager::setupDailyWord() {
    QString dailyWord = getRandomWordFromTxt();

    if (!isWordUsed(dailyWord)) {
        addUsedWord(dailyWord);
        qDebug() << "Today's word set in" << Language << ":" << dailyWord;
    }
}


// Rastgele kelime seçer
QString FileManager::getRandomWordFromTxt() {
    QFile file(wordListFilePath);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Word list file could not be opened!";
        return "";
    }

    QStringList wordList = QTextStream(&file).readAll().split('\n', Qt::SkipEmptyParts);
    file.close();

    if (wordList.isEmpty()) {
        qWarning() << "Word list is empty!";
        return "";
    }

    return wordList.at(QRandomGenerator::global()->bounded(wordList.size())).trimmed();
}

// Kelimenin daha önce kullanılıp kullanılmadığını kontrol eder
bool FileManager::isWordUsed(const QString &word) {
    QFile file(dailyWordFilePath);
    QTextStream in(&file);
    while (!in.atEnd()) {
        if (in.readLine() == word) {
            file.close();
            return true;
        }
    }

    file.close();
    return false;
}

// Kullanılmış kelimeyi kaydeder
void FileManager::addUsedWord(const QString &dailyWord) {
    QFile file(dailyWordFilePath);
    if (!file.open(QIODevice::Append | QIODevice::Text)) {
        qWarning() << "Daily word file could not be opened for appending!";
        return;
    }

    QTextStream out(&file);
    out << dailyWord << "\n";
    DailyWord = dailyWord;
    file.close();
}

QString FileManager::getDailyWord() const {
    return DailyWord;
}
