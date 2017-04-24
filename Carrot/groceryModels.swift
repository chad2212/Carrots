//
//  groceryItem.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
import SQLite
//holds the data for a grocery Item
struct groceryType{
    let title : String
    let image : UIImage
}

struct groceryItem{
    var id : Int64
    var name : String
    var count : Double
    var storedLocation : String
    var purchasedDate : Date
    var expiringDate : Date
    var foodType : String
    var units : String
    
    func addItem(name:String, count:Double)
    {
        var counter : Int = 0
        for item in localGroceryList
        {
            if (item.name == name)
            {
                localGroceryList[counter].count+=1
            }
            counter+=1
        }
    }
    
    func checkIfExist(name:String) -> Bool
    {
        for item in localGroceryList
        {
            if (item.name == name)
            {
                return true
            }
        }
        return false
    }
}

var localGroceryList:[groceryItem] = []

