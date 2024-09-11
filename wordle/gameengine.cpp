#include "gameengine.h"

GameEngine::GameEngine(QObject *parent)
    : QObject(parent), unlimitedPlay(false), currentLanguage("en") {}

// Oyun başlatma fonksiyonu
void GameEngine::startGame() {
    fileManager.setupDailyWord(); // Eğer setupDailyWord() parametresiz ise
    qDebug() << "Game started with language:" << currentLanguage << "and unlimited play:" << unlimitedPlay;
}

// Dil ayarlarını yapar
void GameEngine::setLanguage(const QString &lang) {
    currentLanguage = lang;
    fileManager.setWordListFilePath(lang == "tr" ? ":/5-letter-words-tr.txt" : ":/5-letter-words-en.txt"); // Doğru fonksiyon çağrısı
    qDebug() << "Language set to:" << currentLanguage;
}

// Oyun modunu ayarlar
void GameEngine::setUnlimitedPlay(bool enabled) {
    unlimitedPlay = enabled;
    qDebug() << "Unlimited play set to:" << unlimitedPlay;
}
