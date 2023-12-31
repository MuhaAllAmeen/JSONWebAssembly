#include <QCoreApplication>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc,argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
