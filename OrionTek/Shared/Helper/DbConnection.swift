//
//  DbConnection.swift
//  OrionTek (iOS)
//
//  Created by Perla Moreno de jesus on 23/6/21.
//

import Foundation
import SQLite3
import SwiftUI

class DbConnection {
    private var database: DbConnection!
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var db : OpaquePointer?
    var path : String = "orionTekDB.sqlite"
    
    init()
    {
        self.db = createDb()
        self.createTableDemo()
    }
    
    func createDb() -> OpaquePointer? {
        
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db: OpaquePointer?
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
            print("Some error ocurred creating db")
            return nil
        }
        else{
            print("Db created succesfully in \(path)")
            return db
        }
        
    }
    
    func createTableDemo() {
        let query = "CREATE TABLE IF NOT EXISTS ClientAddress(Id INTEGER PRIMARY KEY NOT NULL, userID CHAR(255), country CHAR(255), city CHAR(255), zipcode CHAR(255), street CHAR(255), streetNumber CHAR(255));"
        
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK
        {
            if sqlite3_step(createTable) == SQLITE_DONE
            {
                print("ClientAddress Table create Succesfully")
            }
            else
            {
                print("Create Fail")
            }
        }
        else
        {
            print("Preparation table Fail")
        }
    }
    
    func insertDemo(userName: String, userId: String, country: String, city: String, zipcode: String, street: String, streetNumber: String) -> Bool
    {
        var result = false
        let insertSql = "INSERT INTO ClientAddress(userID, country, city, zipcode, street, streetNumber) VALUES (?, ?, ?, ?, ?, ?);"

        var statement : OpaquePointer? = nil
        
        if (sqlite3_prepare(db, insertSql, -1, &statement, nil) == SQLITE_OK) {
            
            sqlite3_bind_text(statement, 1, (userId as NSString).utf8String, -1, nil)
            
            sqlite3_bind_text(statement, 2, (country as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (zipcode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (street as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement,6, (streetNumber as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                
                print("Data insert sucessfully")
                
                result = true
                return result
                
            }else
            {
                let errorMessage = String(cString: sqlite3_errmsg(db))

                print("an error ocurred inserting the data \(errorMessage)")
            }
            
        }
        
        return result
        
    }
    
    public func getAddress(userId: UUID) -> [Address] {
        
       var addressList: [Address] = []

       var query = "Select * From ClientAddress Where userID = ? "
       var statement : OpaquePointer? = nil
       
       if (sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK)
       {
          sqlite3_bind_text(statement, 1, userId.uuidString, -1, nil)

           while sqlite3_step(statement) == SQLITE_ROW {

               let id = Int(sqlite3_column_int(statement, 0))

               let country = String(cString: sqlite3_column_text(statement, 2))

               let city = String(cString: sqlite3_column_text(statement, 3))

               let zipcode = String(cString: sqlite3_column_text(statement, 4))

               let street = String(cString: sqlite3_column_text(statement, 5))

               let streetNumber = String(cString: sqlite3_column_text(statement, 6))

               let addressModel = Address()
            
               addressModel.id = id
               addressModel.country = country
               addressModel.city = city
               addressModel.zipcode = zipcode
               addressModel.street = street
               addressModel.streetNumber = streetNumber
            
               
            addressList.append(addressModel)
        
           }

       }
       else
       {
           print("an error ocurred retrieving the data")
       }
        
        return addressList
    }
    
    func DeleteAddress(addressId: Int){
        let query = "DELETE FROM ClientAddress Where Id = \(addressId)"
        
        var statement : OpaquePointer? = nil
        
        if (sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK) {
            
            if sqlite3_step(statement) == SQLITE_DONE
            {
                print("Data delete sucessfully")

            }else{
                print("an error ocurred inserting the data")
            }
        }
        
    }
    
    func DeleteTable() {
        let query = "DROP TABLE ClientAddress;"

        var statement : OpaquePointer? = nil
        
        if (sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK) {
            print("Table delete sucessfully")

        }else{
            print("Error deleting table")

        }
    }
}
