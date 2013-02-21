#include "conversation.h"

Conversation::Conversation(QObject *parent) :
    QObject(parent)
  , m_Length(0.0)
{
}

double Conversation::length()
{
//	double theLength = 1.0;
//	foreach(QObject* mess, messages()) {
//		Message* pMess = qobject_cast<Message*>(mess);
//		if(pMess)
//			theLength += pMess->length();
//	}
//	emit lengthChanged(m_Length);

	return m_Length;
}
