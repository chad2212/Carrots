//
//  ExpiringViewController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
import SQLite

class ExpiritingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var expiringFoodList:[groceryItem] = []
    
    @IBOutlet var expiringTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        expiringTable.delegate = self
        expiringTable.dataSource = self
        expiringFoodList = SQLiteDB.instance.orderByExpirationDate()!
        expiringTable.reloadData()
        
        
        //Getting data back from database
        
    }
    override func viewDidAppear(_ animated: Bool) {
        expiringFoodList = SQLiteDB.instance.orderByExpirationDate()!
        expiringTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expiringFoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "expiringTableCell", for: indexPath) as! expiringTableCell
            
            let userCalendar = Calendar.current
            
            cell.itemName?.text = expiringFoodList[indexPath.row].name
            cell.itemCount?.text = String(expiringFoodList[indexPath.row].count)
            let daysInBetween = userCalendar.dateComponents([.day], from: Date(), to: expiringFoodList[indexPath.row].expiringDate)
            cell.itemDaysLeft?.text = String(daysInBetween.day!)
            
            return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print ("Here")
        print (expiringFoodList)
        print (expiringFoodList[indexPath.row].name)
        self.performSegue(withIdentifier: "detailedSegue2", sender: expiringFoodList[indexPath.row].name)
    }
      override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if(segue.identifier == "detailedSegue2"){
            let svc = segue.destination as! DetailedGroceryController
            //let indexPath = sender as! IndexPath
            let queryString = sender as! expiringTableCell
            let query = queryString.itemName.text!
            let specificList:[groceryItem] = (SQLiteDB.instance.whereNameMatches(input: query))!
            svc.specificList = specificList
            svc.toPass = query
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //deleting process
        //let tempList:[groceryItem] = selectCorrectList(identifier: (toPass?.title)!)
        if editingStyle == .delete {
            //let deleteElement = tempList[indexPath.row]
            //deleteItem(identifier: deleteElement)
            let cid = expiringFoodList[indexPath.row].id
            if (SQLiteDB.instance.deleteGroceryItem(cid: cid)){
                expiringFoodList = SQLiteDB.instance.orderByExpirationDate()!
                expiringTable.reloadData()
            }
            
            
        }
        
        
    }
}
