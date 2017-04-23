//
//  newGroceryItem.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
import SQLite

class newGroceryItemController: UIViewController {
    

    var db:Connection? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        db = try? Connection("\(path)/db.sqlite3")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToList", sender: self)
    }
    
 
    @IBOutlet var foodNameField: UITextField!
    @IBOutlet var countNumber: UILabel!
    
    
    @IBAction func countStepper(_ sender: UIStepper) {
        countNumber.text = Int(sender.value).description
    }
    
    @IBOutlet var locationField: UITextField!
    
    @IBOutlet var foodTypeField: UITextField!
    
    @IBOutlet var purchasedDateField: UITextField!
    
    @IBOutlet var expirationDateField: UITextField!
    
    @IBAction func createFoodItem(_ sender: UIButton) {
        
        let foodName = foodNameField.text!
        let count = Int64(countNumber.text!)
        let location = locationField.text!
        let foodType = foodTypeField.text!
        //let purchasedDate = stringToDate(dateInString: purchasedDateField.text!)
        //let expirationDate = stringToDate(dateInString: expirationDateField.text!)
        let purchasedDate = purchasedDateField.text!
        let expirationDate = expirationDateField.text!
        
        print("Attempting to add food item with \(foodName), \(count), \(location), \(foodType), \(purchasedDate), \(expirationDate)")
        
        let _ = SQLiteDB.instance.addGroceryItem(addName: foodName, addCount: count!, addStoredLocation: location, addPurchasedDate: purchasedDate, addExpiringDate: expirationDate, addFoodType: foodType)

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
