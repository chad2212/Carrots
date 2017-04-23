//
//  StephencelisDB.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import SQLite


public class SQLiteDB {
    static let instance = SQLiteDB()
    private let db: Connection?
    
    private let foodItems = Table("foodItems")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let count = Expression<Int64>("count")
    private let storedLocation = Expression<String>("storedLocation")
    private let purchasedDate = Expression<String>("purchasedDate")
    private let expiringDate = Expression<String>("expiringDate")
    private let foodType = Expression<String>("foodType")

    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        print("Path: \(path)")
        do {
            db = try Connection("\(path)/db.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }
    
    func createTable() {
        do {
            try db!.run(foodItems.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(name)
                t.column(count)
                t.column(storedLocation)
                t.column(purchasedDate)
                t.column(expiringDate)
                t.column(foodType)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addGroceryItem(addName: String, addCount: Int64, addStoredLocation: String, addPurchasedDate:String, addExpiringDate:String,addFoodType:String) -> Int64? {
        do {
            let insert = foodItems.insert(
                name <- addName,
                count <- addCount,
                storedLocation <- addStoredLocation,
                purchasedDate <- addPurchasedDate,
                expiringDate <- addExpiringDate,
                foodType <- addFoodType
                )
            let id = try db!.run(insert)
            print("Grocery Item successfully added")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func getGroceryItems() -> [groceryItem] {
            var groceryItems = [groceryItem]()
            
            do {
                for item in try db!.prepare(self.foodItems) {
                    groceryItems.append(groceryItem(
                        id: item[id],
                        name: item[name],
                        count: item[count],
                        storedLocation: item[storedLocation],
                        purchasedDate: stringToDate(dateInString: item[purchasedDate]),
                        expiringDate: stringToDate(dateInString: item[expiringDate]),
                        foodType:item[foodType]
                    ))
                }
            } catch {
                print("Select failed")
            }
            
            return groceryItems
    }
        
    func deleteContact(cid: Int64) -> Bool {
            do {
                let item = foodItems.filter(id == cid)
                try db!.run(item.delete())
                return true
            } catch {
                print("Delete failed")
            }
            return false
    }
        
    func updateContact(cid:Int64, newFoodItem: groceryItem) -> Bool {
            let item = foodItems.filter(id == cid)
            do {
                let update = item.update([
                    name <- newFoodItem.name,
                    count <- newFoodItem.count,
                    storedLocation <- newFoodItem.storedLocation,
                    purchasedDate <- dateToString(stringInDate:newFoodItem.purchasedDate),
                    expiringDate <- dateToString(stringInDate:newFoodItem.expiringDate),
                    foodType <- newFoodItem.foodType
                    ])
                if try db!.run(update) > 0 {
                    return true
                }
            } catch {
                print("Update failed: \(error)")
            }
            
            return false
    }
        
}

public func stringToDate(dateInString:String)-> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date = dateFormatter.date(from:dateInString)!
    return date
}

public func dateToString(stringInDate:Date)-> String{
    let myFormatter = DateFormatter()
    myFormatter.dateStyle = .short
    return myFormatter.string(from: stringInDate)
}
