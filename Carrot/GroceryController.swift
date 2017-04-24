//
//  GroceryController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
import SQLite


// THIS IS THE GROCERY CONTROLLER AND SHOULD DISPLAY ALL THE GROCERY ITEMS FOR THE 
//APPROPRIATE CATEGORY
class GroceryController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var groceryItemized: UITableView!
    @IBOutlet var groceryType: UILabel!

    var passingIndexPath:IndexPath? = nil
    
    //4 separate lists
    var allMeatGroceries:[groceryItem] = []
    var allProduceGroceries:[groceryItem] = []
    var allDairyGroceries:[groceryItem] = []
    var allOtherGroceries:[groceryItem] = []
    
    //segue control to go back since it's not a typical push
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        localGroceryList =  SQLiteDB.instance.getGroceryItems()
        separateIntoDifferentList()
        groceryItemized.reloadData()
    }
    
    var toPass: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if(toPass != nil){
            //Load the database here based on the title
            self.groceryType.text = toPass!
        }
        groceryItemized.delegate = self
        groceryItemized.dataSource = self
        groceryItemized.reloadData()
        
        localGroceryList = SQLiteDB.instance.getGroceryItems()
        
        separateIntoDifferentList()
        
        //Getting data back from database

    }
    
    override func viewDidAppear(_ animated: Bool) {
        localGroceryList = SQLiteDB.instance.getGroceryItems()
        separateIntoDifferentList()
        groceryItemized.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectCorrectList(identifier: (toPass!)).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "groceryTableCell", for: indexPath) as! groceryTableCell
            let tempList:[groceryItem] = selectCorrectList(identifier: (toPass!))
            cell.itemName?.text = tempList[indexPath.row].name
            cell.itemNumber?.text = String(tempList[indexPath.row].count) + tempList[indexPath.row].units
            cell.itemLocation?.text = String(tempList[indexPath.row].storedLocation)
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //deleting process
        let tempList:[groceryItem] = selectCorrectList(identifier: (toPass!))
        if editingStyle == .delete {
            let deleteElement = tempList[indexPath.row]
            deleteItem(identifier: deleteElement)
            separateIntoDifferentList()
            if (SQLiteDB.instance.deleteGroceryItem(cid: deleteElement.id))
            {
                groceryItemized.reloadData()
            }
            
            
        }
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailedSegue", sender: indexPath)
    }


    
    func separateIntoDifferentList()
    {
        allMeatGroceries = []
        allProduceGroceries = []
        allDairyGroceries = []
        allOtherGroceries = []
        
        
        
        for item in localGroceryList
        {
            switch item.foodType {
            case "Meat":
                allMeatGroceries.append(item)
            case "Produce":
                allProduceGroceries.append(item)
            case "Dairy":
                allDairyGroceries.append(item)
            case "Others":
                allOtherGroceries.append(item)
            default:
                print("There is an item with a weird type: \(item.name)")
                break
                //do nothing
            }
        }
    }
    
    func selectCorrectList(identifier:String)->[groceryItem]
    {
        switch identifier {
        case "Meat":
            return allMeatGroceries
        case "Produce":
            return allProduceGroceries
        case "Dairy":
            return allDairyGroceries
        case "Others":
            return allOtherGroceries
        default:
            print("Unknown identifier passed into func selectCorrectList in GroceryController.swift")
            return localGroceryList
        }
    }
    
    func deleteItem(identifier: groceryItem)
    {
        if SQLiteDB.instance.deleteGroceryItem(cid: identifier.id) {print("Deleting \(identifier.name) successful")}

        localGroceryList.remove(at: localGroceryList.index(where: {$0.name == identifier.name})!)
        switch identifier.foodType {
        case "Meat":
            allMeatGroceries.remove(at: allMeatGroceries.index(where: {$0.name == identifier.name})!)
        case "Produce":
            allProduceGroceries.remove(at: allProduceGroceries.index(where: {$0.name == identifier.name})!)
        case "Dairy":
            allDairyGroceries.remove(at: allDairyGroceries.index(where: {$0.name == identifier.name})!)
        case "Others":
            allOtherGroceries.remove(at: allOtherGroceries.index(where: {$0.name == identifier.name})!)
        default:
            print("Unknown identifier passed into func deleteItem in GroceryController.swift")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if(segue.identifier == "detailedSegue"){
            let svc = segue.destination as! DetailedGroceryController
            let indexPath = sender as! IndexPath
            let queryString = selectCorrectList(identifier: (toPass!))[(indexPath.row)].name
            let specificList:[groceryItem] = (SQLiteDB.instance.whereNameMatches(input: queryString))!
            svc.specificList = specificList;
            svc.toPass = queryString

        }
    }

}
