#ifndef CONVERSATION_H
#define CONVERSATION_H

#include <QObject>
#include "message.h"
#include <QSignalMapper>

class Conversation : public QObject
{
    Q_OBJECT
	Q_PROPERTY(QList<QObject*> messages READ messages NOTIFY messagesChanged)
	Q_PROPERTY(QStringList authors READ authors NOTIFY authorsChanged)

public:
    explicit Conversation(QObject *parent = 0);
	QList<QObject*> messages() {
		return m_Messages;
	}
	QStringList authors() {
		return m_AuthorsMessages.keys();
	}
    
signals:
	void messagesChanged(QList<QObject*> newMessages);
	void messageAdded(Message* pNewMessage);
	void authorsChanged(QStringList newAuthors);
	void authorAdded(QString author);

public slots:
	void addMessage(Message* pNewMessage) {
		bool oneMoreAuthor  = !authors().contains(pNewMessage->author());
		m_Messages.append(pNewMessage);
		m_AuthorsMessages.insert(pNewMessage->author(), pNewMessage);
		emit messagesChanged(m_Messages);
		emit messageAdded(pNewMessage);
		if(oneMoreAuthor) {
			emit authorsChanged(authors());
			emit authorAdded(pNewMessage->author());
		}
		qDebug() << "message added";
	}
	void addMessageObject(QObject* pNewMessage = 0) {
		Message* pMess = qobject_cast<Message*>(pNewMessage);
		if(pMess)
			addMessage(pMess);
		else
			qDebug() << "message not added";
	}
	void addMessageTimer(Message* pMess, int ms) {
		QTimer* ptimer = new QTimer(this);
		ptimer->setInterval(ms);
		ptimer->setSingleShot(true);
		QSignalMapper* signalMapper = new QSignalMapper(this);
		signalMapper->setMapping(ptimer, pMess);
		connect(ptimer, SIGNAL(timeout()), signalMapper, SLOT(map()));
		connect(signalMapper, SIGNAL(mapped(QObject*)), this, SLOT(addMessageObject(QObject*)));
		ptimer->start();
	}

private:
	QList<QObject*> m_Messages;
	QMap<QString, QObject*> m_AuthorsMessages;

};


#endif // CONVERSATION_H
