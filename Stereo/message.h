#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>

class Message : public QObject
{
    Q_OBJECT
	Q_PROPERTY(QString body READ body)
public:
    explicit Message(QObject *parent, const QString & body);
	QString body() { return m_body; }
    
signals:
    
public slots:

private:
	QString m_body;
    
};

#endif // MESSAGE_H

