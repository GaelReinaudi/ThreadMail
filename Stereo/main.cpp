#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "conversation.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/Stereo/main.qml"));
    viewer.showExpanded();

    Conversation theConv;

    return app.exec();
}
