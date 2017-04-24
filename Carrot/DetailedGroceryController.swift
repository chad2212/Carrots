//
//  DetailedGroceryController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
import SQLite

class DetailedGroceryController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var specificFoodItemDetails:[groceryItem] = []
    
    @IBOutlet var detailedGroceryItemized: UITableView!
    @IBOutlet var foodType: UILabel!
    
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        detailedGroceryItemized.reloadData()
    }
    
    var toPass: String?
    var specificList:[groceryItem] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if((toPass) != nil){
            //Load the database here based on the title
            self.foodType.text = toPass!
        }
        detailedGroceryItemized.delegate = self
        detailedGroceryItemized.dataSource = self
        detailedGroceryItemized.reloadData()
        
        
        
        for item in specificList
        {
            print("in the table view")
            print(specificList)
            print (item.name)
        }
        //Getting data back from database
        
    }
    override func viewDidAppear(_ animated: Bool) {
        detailedGroceryItemized.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print (specificList)

        return specificList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailedGroceryTableCell", for: indexPath) as! detailedGroceryTableCell
            
            cell.itemPurchasedDate?.text = dateToString(stringInDate: specificList[indexPath.row].purchasedDate)
            cell.itemLocation?.text = specificList[indexPath.row].storedLocation
            cell.itemExpiringDate?.text = dateToString(stringInDate: specificList[indexPath.row].expiringDate)
            cell.itemCount?.text = String(specificList[indexPath.row].count)
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //deleting process
        //let tempList:[groceryItem] = selectCorrectList(identifier: (toPass?.title)!)
        if editingStyle == .delete {
            //let deleteElement = tempList[indexPath.row]
            //deleteItem(identifier: deleteElement)
            detailedGroceryItemized.reloadData()
            
        }
        
        
    }
    

}
