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
        if editingStyle == .delete {
            //let deleteElement = localMovieArray[indexPath.row]
            //localMovieArray = localMovieArray.filter() { $0 != deleteElement }
            //reloadFavoriteMovieData(newArr: localMovieArray)
            
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
            case "Other":
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
        print("From selectCorrectList \(identifier)")
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

}
