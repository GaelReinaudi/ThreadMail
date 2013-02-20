#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>

class Message : public QObject
{
    Q_OBJECT
public:
    explicit Message(QObject *parent, const QString & body);
    
signals:
    
public slots:
    
};

#endif // MESSAGE_H
