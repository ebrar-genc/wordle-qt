#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "gameengine.h"
#include "filemanager.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    FileManager fileManager;
    GameEngine gameEngine(nullptr, &fileManager);


    // QML'e C++ objeleri bağlandı
    engine.rootContext()->setContextProperty("gameEngine", &gameEngine);
    engine.rootContext()->setContextProperty("fileManager", &fileManager);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
