//
//  DetailedGroceryController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit


class DetailedGroceryController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var specificFoodItemDetails:[groceryItem] = []
    
    @IBOutlet var detailedGroceryItemized: UITableView!
    @IBOutlet var foodType: UILabel!
    
    
    var toPass: String?
    var specificList:[groceryItem] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if((toPass) != nil){
            self.foodType.text = toPass!
        }
        detailedGroceryItemized.delegate = self
        detailedGroceryItemized.dataSource = self
        detailedGroceryItemized.reloadData()
        
        
        //Getting data back from database
        
    }
    override func viewDidAppear(_ animated: Bool) {
        specificList = SQLiteDB.instance.whereNameMatches(input: toPass!)!
        detailedGroceryItemized.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailedGroceryTableCell", for: indexPath) as! detailedGroceryTableCell
            
            cell.itemPurchasedDate?.text = dateToString(stringInDate: specificList[indexPath.row].purchasedDate)
            cell.itemLocation?.text = specificList[indexPath.row].storedLocation
            cell.itemExpiringDate?.text = dateToString(stringInDate: specificList[indexPath.row].expiringDate)
            cell.itemCount?.text = String(specificList[indexPath.row].count) +  " " + specificList[indexPath.row].units
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //deleting process
        //let tempList:[groceryItem] = selectCorrectList(identifier: (toPass?.title)!)
        if editingStyle == .delete {
            //let deleteElement = tempList[indexPath.row]
            //deleteItem(identifier: deleteElement)
            let cid = specificList[indexPath.row].id
            if (SQLiteDB.instance.deleteGroceryItem(cid: cid))
            {
                specificList = SQLiteDB.instance.whereNameMatches(input: toPass!)!
                detailedGroceryItemized.reloadData()
            }
            
            
        }
        
        
    }
    

}
