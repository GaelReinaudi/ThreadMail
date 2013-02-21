#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>
#include <QtQml>

class Conversation;

class Message : public QObject
{
    Q_OBJECT
	Q_PROPERTY(QString body READ body NOTIFY bodyChanged)
	Q_PROPERTY(QString author READ author CONSTANT)
	Q_PROPERTY(int length READ length WRITE setLength NOTIFY lengthChanged)
	Q_PROPERTY(Conversation* conversation READ conversation)
	Q_PROPERTY(double ratio READ ratio NOTIFY ratioChanged)

public:
	explicit Message(Conversation *parent = 0, const QString & body = "no body", const QString & author = "me");
	QString body() { return m_body; }
	QString author() { return m_Author; }
	double length() { return m_Length ? m_Length : body().size(); }
	Conversation* conversation() { return m_Conv; }
	double ratio();

signals:
	void bodyChanged(QString newBody);
	void lengthChanged(int theLength);
	void ratioChanged(double newRatio);

public slots:
	bool isAuthor(const QString & auth) {
		return auth == author();
	}
	void setLength(double newLength) {
		m_Length = newLength;
		qDebug() << newLength;
		emit lengthChanged(m_Length);
		emit ratioChanged(ratio());
	}

private:
	QString m_body;
	QString m_Author;
	Conversation* m_Conv;
	double m_Length;
};

#endif // MESSAGE_H

