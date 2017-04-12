//
//  newGroceryItem.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

class newGroceryItemController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToList", sender: self)
    }
    
    @IBAction func addApple(_ sender: UIButton) {
        if checkIfExist(name: "Apple")
        {
            addItem(name:"Apple",count:1)
        }
        else
        {
            localGroceryList.append(groceryItem(name:"Apple",count:1,stored:"R",purchasedDate: Date(), expiringDate: Date(), type: "Produce"))
        }
        
    }
    
    @IBAction func addBanana(_ sender: UIButton) {
        if checkIfExist(name: "Banana")
        {
            addItem(name:"Banana",count:1)
        }
        else
        {
            localGroceryList.append(groceryItem(name:"Banana",count:1,stored:"R",purchasedDate: Date(), expiringDate: Date(), type: "Produce"))
        }    }

    @IBAction func addGroundBeef(_ sender: UIButton) {
        if checkIfExist(name: "Ground Beef")
        {
            addItem(name:"Ground Beef",count:1)
        }
        else
        {
            localGroceryList.append(groceryItem(name:"Ground Beef",count:1,stored:"R",purchasedDate: Date(), expiringDate: Date(), type: "Meat"))
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
}
