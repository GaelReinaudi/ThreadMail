#include "message.h"
#include "conversation.h"


Message::Message(Conversation *parent, const QString & body, const QString & author) :
    QObject(parent)
  , m_Conv(parent)
{
	m_body = body;
	emit bodyChanged(m_body);
	emit lengthChanged(length());
	m_Author = author;
}

double Message::ratio()
{
	return length() / conversation()->length();
}
