//
//  DBFunctions.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-29.
//

import UIKit
import SQLite3

class DBFunctions: NSObject {
    let strDatabasePath: String = "remindme.sqlite"
    var ptrDatabase: OpaquePointer?
    
    override init()
    {
        super.init()
        ptrDatabase = self.openDatabase()
        self.createTable()
    }
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(strDatabasePath)
        var ptrDatabase: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &ptrDatabase) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(strDatabasePath)")
            return ptrDatabase
        }
    }
    func createTable() {
        let strQueryCreateTable = "CREATE TABLE IF NOT EXISTS friend(Name TEXT,Surname TEXT,Relation TEXT,DOB TEXT,DOA TEXT,Phone VARCHAR,Email TEXT PRIMARY KEY);"
        var strStmtCreateTable: OpaquePointer? = nil
        if sqlite3_prepare_v2(ptrDatabase, strQueryCreateTable, -1, &strStmtCreateTable, nil) == SQLITE_OK
        {
            if sqlite3_step(strStmtCreateTable) == SQLITE_DONE
            {
                print("table created.")
            } else {
                print("table not created.")
            }
        } else {
            print("Problem in Statement")
        }
        sqlite3_finalize(strStmtCreateTable)
    }
    func insert(name:String, surname:String, relation:String ,DOB:String ,DOA:String ,phone: String ,email:String)-> Bool
    {
        var flagStatus: Bool = false
        let friend = read()
        for strVal in friend
        {
            if strVal.email == email
            {
                flagStatus = false
            }
        }
        let strQueryInsert = "INSERT INTO friend (Name, Surname ,Relation ,DOB ,DOA ,Phone ,Email) VALUES (?, ?, ? ,? ,? ,? ,?);"
        var strStmtInsert: OpaquePointer? = nil
        if sqlite3_prepare_v2(ptrDatabase, strQueryInsert, -1, &strStmtInsert, nil) == SQLITE_OK {
            sqlite3_bind_text(strStmtInsert, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(strStmtInsert, 2, (surname as NSString).utf8String, -1,nil)
            sqlite3_bind_text(strStmtInsert, 3, (relation as NSString).utf8String, -1,nil)
            sqlite3_bind_text(strStmtInsert, 4, (DOB as NSString).utf8String, -1,nil)
            sqlite3_bind_text(strStmtInsert, 5, (DOA as NSString).utf8String, -1,nil)
            sqlite3_bind_text(strStmtInsert, 6, (phone as NSString).utf8String, -1,nil)
            sqlite3_bind_text(strStmtInsert, 7, (email as NSString).utf8String, -1,nil)

            if sqlite3_step(strStmtInsert) == SQLITE_DONE {
               // print("Successfully inserted row.")
                flagStatus = true
            } else {
                //print("Could not insert row.")
                flagStatus = false
            }
        } else {
           // print("INSERT not be prepared.")
            flagStatus = false
        }
        sqlite3_finalize(strStmtInsert)
        return flagStatus
    }
    func read() -> [Friend] {
        let strQueryRead = "SELECT * FROM friend;"
        var strStmtRead: OpaquePointer? = nil
        var objFriend : [Friend] = []
        if sqlite3_prepare_v2(ptrDatabase, strQueryRead, -1, &strStmtRead, nil) == SQLITE_OK {
            while sqlite3_step(strStmtRead) == SQLITE_ROW {
                let strName = String(describing: String(cString: sqlite3_column_text(strStmtRead, 0)))
                let strSurname = String(describing: String(cString: sqlite3_column_text(strStmtRead, 1)))
                let strRelation = String(describing: String(cString: sqlite3_column_text(strStmtRead, 2)))
                let strDOB = String(describing: String(cString: sqlite3_column_text(strStmtRead, 3)))
                let strDOA = String(describing: String(cString: sqlite3_column_text(strStmtRead, 4)))
                let strPhone = String(describing: String(cString: sqlite3_column_text(strStmtRead, 5)))
                let strEmail = String(describing: String(cString: sqlite3_column_text(strStmtRead, 6)))

                objFriend.append(Friend(name: strName, surname: strSurname, relation: strRelation, DOB: strDOB, DOA: strDOA, phone: strPhone, email: strEmail))
            }
        } else {
            print("SELECT not prepared")
        }
        sqlite3_finalize(strStmtRead)
        return objFriend
    }
    func deleteByEmailID(email:String) -> Bool {
        var flagStatus: Bool = false
        let strQueryDelete = "DELETE FROM friend WHERE Email = ?;"
        var strStmtDelete: OpaquePointer? = nil
        if sqlite3_prepare_v2(ptrDatabase, strQueryDelete, -1, &strStmtDelete, nil) == SQLITE_OK {
            sqlite3_bind_text(strStmtDelete
                              , 1, (email as NSString).utf8String, -1,nil)
            if sqlite3_step(strStmtDelete) == SQLITE_DONE {
                //print("Successfully deleted row.")
                flagStatus = true
            } else {
                //print("Could not delete row.")
                flagStatus = false
            }
        } else {
            //print("DELETE not prepared")
            flagStatus = false
        }
        sqlite3_finalize(strStmtDelete)
        return flagStatus
    }
    func update(query : String) -> Bool {
        var flagStatus: Bool = false
        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(ptrDatabase, query, -1, &updateStatement, nil) ==
          SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
               // print("\nSuccessfully updated row.")
                flagStatus = true
            } else {
                //print("\nCould not update row.")
                flagStatus = false
            }
        } else {
            //print("\nUPDATE statement is not prepared")
            flagStatus = false
        }
        sqlite3_finalize(updateStatement)
        return flagStatus
    }
}
