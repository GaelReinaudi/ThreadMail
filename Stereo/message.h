#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>
#include <QtQml>

class Message : public QObject
{
    Q_OBJECT
	Q_PROPERTY(QString body READ body NOTIFY bodyChanged)
public:
	explicit Message(QObject *parent = 0, const QString & body = "no body", const QString & author = "me");
	QString body() { return m_body; }
    
signals:
	void bodyChanged(QString newBody);

public slots:

private:
	QString m_body;
    
};


#endif // MESSAGE_H

