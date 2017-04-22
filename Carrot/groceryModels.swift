//
//  groceryItem.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

struct groceryType{
    let title : String
    let image : UIImage
}

struct groceryItem{
    var name : String
    var count : Int
    var storedLocation : String
    var purchasedDate : Date
    var expiringDate : Date
    var foodType : String
    
    func addItem(name:String, count:Int)
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
