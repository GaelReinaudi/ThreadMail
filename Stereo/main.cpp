#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QTimer>

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	QtQuick2ApplicationViewer viewer;
	viewer.showExpanded();

	viewer.m_QmlFile = "qml/Stereo/main.qml";
	viewer.ReloadQmlFile();

//	QTimer reloader;
//	reloader.setInterval(1000);
//	QObject::connect(&reloader, SIGNAL(timeout()), &viewer, SLOT(ReloadQmlFile()), Qt::QueuedConnection);
//	reloader.start();

	return app.exec();
}
