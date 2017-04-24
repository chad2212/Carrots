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
    
    
    
    
    //recipe table
    private let recipes = Table("recipes");
    private let recipeID = Expression<Int64>("recipeID");
    private let recipeName = Expression<String>("recipeName");
    
    
    //ingredient table
    private let ingredients = Table("ingredients");
    private let relatedRecipeID = Expression<Int64>("relatedrecipeID");
    private let ingredientName = Expression<String>("ingredientName");
    private let ingredientCount = Expression<Int64>("ingredientCount");
    private let ingredientMeasurement = Expression<String>("ingredientMeasurement");
    

    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        print("Path: \(path) \n")
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
        do {
            try db!.run(recipes.create(ifNotExists: true) { t in
                t.column(recipeID, primaryKey: .autoincrement) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(recipeName)
            })
        } catch {
            print("Unable to create table")
        }
        do {
            try db!.run(ingredients.create(ifNotExists: true) { t in
                t.column(relatedRecipeID, references: recipes,recipeID) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(ingredientName)
                t.column(ingredientCount)
                t.column(ingredientMeasurement)
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
    
    func addRecipe(addName: String) -> Int64?{
        do {
            let insert = recipes.insert(
                recipeName <- addName
            )
            let id = try db!.run(insert)
            return id
        } catch {
            return -1
        }
    }
    
    func addIngredient(addRecipeID: Int64, addIngredientName: String, addIngredientCount: Int64, addMeasurementType:String) -> Int64?{
        do {
            let insert = ingredients.insert(
                relatedRecipeID <- addRecipeID,
                ingredientName <- addIngredientName,
                ingredientCount <- addIngredientCount,
                ingredientMeasurement <- addMeasurementType
            )
            let id = try db!.run(insert)
            return id
        } catch {
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
        
    func deleteGroceryItem(cid: Int64) -> Bool {
            do {
                let item = foodItems.filter(id == cid)
                try db!.run(item.delete())
                return true
            } catch {
                print("Delete failed")
            }
            return false
    }
        
    func updateGroceryItem(cid:Int64, newFoodItem: groceryItem) -> Bool {
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
    
    func incrementGroceryItem(cid:Int64) -> Bool {
        let item = foodItems.filter(id == cid)
        do{
            if try db!.run(item.update(count++)) > 0{
                return true
            }
        } catch {
            print ("Counter Increment failed for ")
        }
        return false
    }
    
    func whereNameMatches(input:String) -> [groceryItem]? {
        var groceryItems = [groceryItem]()
        
        do
        {
            let items = try db!.prepare(foodItems.filter(name == input))
            for item in items{
                groceryItems.append(groceryItem(id: item[id], name: item[name], count: item[count], storedLocation: item[storedLocation], purchasedDate: stringToDate(dateInString: item[purchasedDate]), expiringDate: stringToDate(dateInString: item[expiringDate]), foodType: item[foodType]));
            }
        }
        catch{
            print("Couldn't filter with matching names")
        }
            
        
        
        
        return groceryItems
    }
    
    func orderByExpirationDate() -> [groceryItem]? {
        var groceryItems = [groceryItem]()
        
        do
        {
            let items = try db!.prepare(foodItems.order(expiringDate.desc))
            for item in items{
                groceryItems.append(groceryItem(id: item[id], name: item[name], count: item[count], storedLocation: item[storedLocation], purchasedDate: stringToDate(dateInString: item[purchasedDate]), expiringDate: stringToDate(dateInString: item[expiringDate]), foodType: item[foodType]));
            }
        }
        catch {
            print ("Couldn't sort by expiration date")
        }
        return groceryItems
    }
    
    
    func getRecipeItems() -> [recipe] {
        var recipes = [recipe]()
        do {
            for item in try db!.prepare(self.recipes) {
                let relevantIngredients = try db!.prepare(self.ingredients.filter(relatedRecipeID == item[recipeID]))
                var ingredientList = [ingredientItem]()
                for groceryItem in relevantIngredients
                {
                    ingredientList.append(ingredientItem(
                        id: groceryItem[relatedRecipeID],
                        name: groceryItem[ingredientName],
                        count: groceryItem[ingredientCount],
                        measurementType: groceryItem[ingredientMeasurement]
                    ))
                }
                recipes.append(recipe(
                    id: item[recipeID],
                    name: item[recipeName],
                    ingredientList: ingredientList
                ))
            }
        } catch {
            print("Retrieving all recipes failed")
        }
        
        return recipes
    }
    
    func getIngredients(recipeID:Int64) -> [ingredientItem] {
        var ingredientList = [ingredientItem]()
        do{
            let ingredientQuery = self.ingredients.filter(relatedRecipeID == recipeID)
            let ingredientTable = try db!.prepare(ingredientQuery)
            for ingredient in ingredientTable{
                ingredientList.append(ingredientItem(id: ingredient[relatedRecipeID], name: ingredient[ingredientName], count: ingredient[ingredientCount], measurementType: ingredient[ingredientMeasurement]))
            }
        } catch {
            print ("Retrieving all ingredients failed")
        }
        return ingredientList
    }

    
    func findNumberMissing(inputID: Int64) -> String {
        var groceryNames = [String]()
        var groceryCounts = [Int]()
        var presentIngredientCounter = 0 ;
        var totalIngredients = 0 ;
        do
        {
            let items = try db!.prepare(foodItems)
            for item in items{
                groceryNames.append(item[name]);
                groceryCounts.append(Int(item[count]));
            }
            
        }
        catch{
            print("Nothing was found")
        }
        
        do
        {
            let ingredients = try db!.prepare(self.ingredients.filter(relatedRecipeID == Int64(inputID) ));
            for ingredient in ingredients{
                let ingredientName = ingredient[self.ingredientName];
                let ingredientCount = ingredient[self.ingredientCount];
                totalIngredients += 1;
                if(groceryCounts.count > 0)
                {
                    for index in 0...groceryCounts.count-1
                    {
                    
                        if(groceryNames[index] == ingredientName && Int64(groceryCounts[index]) >=  ingredientCount)
                        {
                            presentIngredientCounter += 1;
                        }
                    }
                }
            }
        }
        catch {
            print("Nothing was found in ingrdeints");
        }
        let missingIngredientCounter = totalIngredients - presentIngredientCounter
        return String(missingIngredientCounter);
        
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
