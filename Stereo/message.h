#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>
#include <QtQml>

class Message : public QObject
{
    Q_OBJECT
	Q_PROPERTY(QString body READ body NOTIFY bodyChanged)
	Q_PROPERTY(int length READ length NOTIFY lengthChanged)

public:
	explicit Message(QObject *parent = 0, const QString & body = "no body", const QString & author = "me");
	QString body() { return m_body; }
	QString author() { return m_Author; }
	int length() { return body().size(); }

signals:
	void bodyChanged(QString newBody);
	void lengthChanged(int theLength);

public slots:

private:
	QString m_body;
	QString m_Author;
    
};


#endif // MESSAGE_H

