//
//  recipeTableController.swift
//  Carrot
//
//  Created by Alan Soetikno on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

class recipeTableController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    var recipeList:[recipe] = []

    
    
    @IBOutlet var recipeTable: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        recipeTable.delegate = self
        recipeTable.dataSource = self
        recipeTable.reloadData()
       

        recipeList =  SQLiteDB.instance.getRecipeItems()
        
        
        //Getting data back from database
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //Todo: DATABASE LOADING HERE
        recipeTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return recipeList.count
        return recipeList.count;
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! recipeCell

            cell.recipeName?.text = recipeList[indexPath.row].name
            let id = recipeList[indexPath.row].id;
            cell.recipeMissingCount?.text = SQLiteDB.instance.findNumberMissing(inputID: id);
            print ("cell")
            return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            /*
            let cid = specificList[indexPath.row].id
            if (SQLiteDB.instance.deleteGroceryItem(cid: cid))
            {
                specificList = SQLiteDB.instance.whereNameMatches(input: toPass!)!
                detailedGroceryItemized.reloadData()
            }
 */
            
            
        }
    }
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print ("Here")
        print (recipeList)
        //self.performSegue(withIdentifier: "detailedSegue2", sender: expiringFoodList[indexPath.row].name)
    }
    
    @IBAction func unwindToRecipeTable(segue:UIStoryboardSegue) {
        localGroceryList =  SQLiteDB.instance.getGroceryItems()
        recipeList =  SQLiteDB.instance.getRecipeItems()
        recipeTable.reloadData()
    }


}
