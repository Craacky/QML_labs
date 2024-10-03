#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "database.h"
#include "listmodel.h"

int main(int argc, char *argv[]) {
    /*qputenv("QT_QUICK_CONTROLS_MATERIAL_THEME", QByteArray("Dark"));
    qputenv("QT_QUICK_CONTROLS_MATERIAL_BACKGROUND", QByteArray("Dark"));
    qputenv("QT_QUICK_CONTROLS_MATERIAL_FOREGROUND", QByteArray("Dark"));
    qputenv("QT_QUICK_CONTROLS_MATERIAL_VARIANT", QByteArray("Dark"));
    qputenv("QT_QUICK_CONTROLS_MATERIAL_PRIMARY", QByteArray("Green"));
    qputenv("QT_QUICK_CONTROLS_MATERIAL_ACCENT", QByteArray("Green"));*/
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    database database;
    database.connectToDataBase();
    listmodel *model = new listmodel();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("myModel", model);
    engine.rootContext()->setContextProperty("database", &database);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
