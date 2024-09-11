#include "filemanager.h"
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QRandomGenerator>
#include <QDebug>
#include <QStandardPaths>

FileManager::FileManager(QObject *parent)
    : QObject(parent), m_language("en") {
    updateFilePath();
}

void FileManager::setWordListFilePath(const QString &path) {
    wordListFilePath = path;
    qDebug() << "Word list file path set to:" << wordListFilePath;
}

// Günlük kelimeyi ayarlar
void FileManager::setupDailyWord() {
    QString dailyWord = getRandomWordFromTxt();

    if (!isWordUsed(dailyWord)) {
        addUsedWord(dailyWord);
        qDebug() << "Today's word set in" << m_language << ":" << dailyWord;
    }
}

// Dil ayarları için getter ve setter
QString FileManager::language() const {
    return m_language;
}

void FileManager::setLanguage(const QString &lang) {
    if (m_language != lang) {
        m_language = lang;
        updateFilePath(); // Dosya yolunu günceller
        setupDailyWord(); // Yeni günlük kelimeyi ayarla
    }
    qDebug() << "Language set to:" << m_language;
    setupDailyWord();
}

// Dosya yollarını dil seçimine göre günceller
void FileManager::updateFilePath() {
    QString localPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(localPath); // Dizin yoksa oluştur

    if (m_language == "tr") {
        dailyWordFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\daily-word-tr.txt"; // Yerel dosya yolu
        wordListFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\5-letter-words-tr.txt"; // Yerel dosya yolu
    } else {
        dailyWordFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\daily-word-en.txt"; // Yerel dosya yolu
        wordListFilePath = "C:\\Users\\gence\\Documents\\GitHub\\wordle-qt\\wordle\\Dataset\\5-letter-words-en.txt"; // Yerel dosya yolu
    }

    qDebug() << "File paths updated: " << dailyWordFilePath << " and " << wordListFilePath;
}
// Rastgele kelime seçer
QString FileManager::getRandomWordFromTxt() {
    QFile file(wordListFilePath);

    // Dosyayı açma işlemi
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Word list file could not be opened!";
        return "";
    }

    // Tüm kelimeleri oku ve rastgele birini seç
    QStringList wordList = QTextStream(&file).readAll().split('\n', Qt::SkipEmptyParts);
    file.close();

    int randomIndex = QRandomGenerator::global()->bounded(wordList.size());
    return wordList.at(randomIndex).trimmed();
}

// Kelimenin daha önce kullanılıp kullanılmadığını kontrol eder
bool FileManager::isWordUsed(const QString &word) {
    QFile file(dailyWordFilePath);
    QTextStream in(&file);
    while (!in.atEnd()) {
        if (in.readLine() == word) {
            file.close();
            return true; // Kelime daha önce kullanılmış
        }
    }

    file.close();
    return false;
}

// Kullanılmış kelimeyi kaydeder
void FileManager::addUsedWord(const QString &word) {
    QFile file(dailyWordFilePath);
    if (!file.open(QIODevice::Append | QIODevice::Text)) {
        qWarning() << "Daily word file could not be opened for appending!";
        return;
    }

    QTextStream out(&file);
    out << word << "\n";
    file.close();
}
