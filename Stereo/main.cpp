#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QTimer>
#include "message.h"
#include "conversation.h"

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	qmlRegisterType<Message>("basalt.Message", 1, 0, "Message");
	qmlRegisterType<Conversation>("basalt.Conversation", 1, 0, "Converstation");


	QtQuick2ApplicationViewer viewer;
	viewer.showExpanded();

	viewer.MakeConversation();

	viewer.m_QmlFile = "qml/Stereo/main.qml";
	viewer.ReloadQmlFile();


//	QTimer reloader;
//	reloader.setInterval(1000);
//	QObject::connect(&reloader, SIGNAL(timeout()), &viewer, SLOT(ReloadQmlFile()), Qt::QueuedConnection);
//	reloader.start();

	return app.exec();
}
