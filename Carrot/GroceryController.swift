//
//  GroceryController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit




class GroceryController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var groceryItemized: UITableView!
    @IBOutlet var groceryType: UILabel!
    
    //4 separate lists
    var allMeatGroceries:[groceryItem] = []
    var allProduceGroceries:[groceryItem] = []
    var allDairyGroceries:[groceryItem] = []
    var allOtherGroceries:[groceryItem] = []
    
    //segue control to go back since it's not a typical push
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        separateIntoDifferentList()
        groceryItemized.reloadData()
    }
    
    var toPass: groceryType?
    
    override func viewDidLoad() {
        //Just as a test
        
        super.viewDidLoad()
        if((toPass?.title) != nil){
            //Load the database here based on the title
            self.groceryType.text = toPass?.title
        }
        groceryItemized.delegate = self
        groceryItemized.dataSource = self
        groceryItemized.reloadData()
        separateIntoDifferentList()
        // Do view setup here.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        separateIntoDifferentList()
        groceryItemized.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectCorrectList(identifier: (toPass?.title)!).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "groceryTableCell", for: indexPath) as! groceryTableCell
            let tempList:[groceryItem] = selectCorrectList(identifier: (toPass?.title)!)
            cell.itemName?.text = tempList[indexPath.row].name
            cell.itemNumber?.text = String(tempList[indexPath.row].count)

            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //deleting process
        let tempList:[groceryItem] = selectCorrectList(identifier: (toPass?.title)!)
        if editingStyle == .delete {
            let deleteElement = tempList[indexPath.row]
            deleteItem(identifier: deleteElement)
            separateIntoDifferentList()
            groceryItemized.reloadData()
            
        }
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row): \(selectCorrectList(identifier: (toPass?.title)!)[indexPath.row])")
    }

    
    func loadFromDB()
    {
        //to be implemented
    }
    
    func separateIntoDifferentList()
    {
        allMeatGroceries = []
        allProduceGroceries = []
        allDairyGroceries = []
        allOtherGroceries = []
        
        for item in localGroceryList
        {
            switch item.type {
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
        localGroceryList.remove(at: localGroceryList.index(where: {$0.name == identifier.name})!)
        switch identifier.type {
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

}
