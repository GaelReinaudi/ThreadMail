#ifndef CONVERSATION_H
#define CONVERSATION_H

#include <QObject>
#include "message.h"

class Conversation : public QObject
{
    Q_OBJECT
	Q_PROPERTY(QList<Message*> messages READ messages NOTIFY messagesChanged)

public:
    explicit Conversation(QObject *parent = 0);
	QList<Message*> messages() {
		return m_Messages;
	}
    
signals:
	void messagesChanged(QList<Message*> newMessages);
    
public slots:
	void addMessage(Message* pNewMessage) {
		m_Messages.append(pNewMessage);
		emit messagesChanged(m_Messages);
	}

private:
	QList<Message*> m_Messages;
    
};

#endif // CONVERSATION_H
