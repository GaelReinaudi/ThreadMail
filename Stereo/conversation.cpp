#include "conversation.h"

Conversation::Conversation(QObject *parent) :
    QObject(parent)
{
}

double Conversation::length()
{
	double theLength = 1.0;
	foreach(QObject* mess, messages()) {
		Message* pMess = qobject_cast<Message*>(mess);
		if(pMess)
			theLength += pMess->length();
	}

	return theLength;
}
