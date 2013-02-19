#ifndef MESSAGE_H
#define MESSAGE_H

#include <QObject>

class message : public QObject
{
    Q_OBJECT
public:
    explicit message(QObject *parent = 0);
    
signals:
    
public slots:
    
};

#endif // MESSAGE_H
