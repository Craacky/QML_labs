#include "database.h"
#include <QSqlDatabase>

database::~database() {
    closeDataBase();
}
database::database(QObject *parent) : QObject(parent) {

}

//main
void database:: connectToDataBase(){

    if(!QFile(DATABASE_NAME).exists()){
        this->restoreDataBase();
    }else{
        this->openDataBase();
    }

}

bool database:: restoreDataBase(){

    if(this->openDataBase()){
        return(this->createTable() ? true : false);
    }else{
        qDebug() << "Can't restore database!";
        return false;
    }
    return false;
}

bool database:: openDataBase(){

    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName(DATABASE_NAME);
    if(db.open()){
        return true;
    }else{
        return false;
    }
}

void database:: closeDataBase(){
    db.close();
}

bool database:: createTable(){
    QSqlQuery query;

    if(!query.exec("CREATE TABLE " TABLE " ("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                    TABLE_FNAME "VARCHAR(255)   NOT NULL"
                    TABLE_SNAME "VARCHAR(255)   NOT NULL"
                    TABLE_MNAME "VARCHAR(255)   NOT NULL"
                    TABLE_PHONE "VARCHAR(255)   NOT NULL"
                    " )"
                    )){
        qDebug() << "Database: error of create" << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }else{
        return true;
    }
    return false;

}

bool database:: insertIntoTable(const QVariantList &data){
    QSqlQuery query;
    query.prepare("INSERT INTO " TABLE " ( " TABLE_FNAME ", "
                  TABLE_SNAME ", "
                  TABLE_PHONE " ) "
                  "VALUES (:FirstName, :SurName, :Phone)");
    query.bindValue(":FirstName", data[0].toString());
    query.bindValue(":SurName", data[1].toString());
    query.bindValue(":MidleName", data[2].toString());
    query.bindValue(":Phone", data[3].toString());

    if(!query.exec()){
        qDebug() << "error insert into" << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }else{
        return true;
    }
    return false;
}

//main
bool database::insertIntoTable(const QString &fname, const QString &sname, const QString &mname, const QString &phone){
    QVariantList data;

    data.append(fname);
    data.append(sname);
    data.append(mname);
    data.append(phone);

    if(insertIntoTable(data)){
        return true;
    }else{
        return false;
    }
}

bool database::removeRecord(const int id){
    QSqlQuery query;
    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug() << "error delete row" << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }else{
        return true;
    }
    return false;
}
