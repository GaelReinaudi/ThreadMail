#ifndef CONVERSATION_H
#define CONVERSATION_H

#include <QObject>
#include "message.h"

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
	void authorsChanged(QStringList newAuthors);

public slots:
	void addMessage(Message* pNewMessage) {
		bool oneMoreAuthor  = !authors().contains(pNewMessage->author());
		m_Messages.append(pNewMessage);
		m_AuthorsMessages.insert(pNewMessage->author(), pNewMessage);
		emit messagesChanged(m_Messages);
		if(oneMoreAuthor)
			emit authorsChanged(authors());
	}

private:
	QList<QObject*> m_Messages;
	QMap<QString, QObject*> m_AuthorsMessages;

};


#endif // CONVERSATION_H
