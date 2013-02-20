#include "message.h"


Message::Message(QObject *parent, const QString & body, const QString & author) :
    QObject(parent)
{
	m_body = body;
	emit bodyChanged(m_body);
	emit lengthChanged(length());
	m_Author = author;
}
