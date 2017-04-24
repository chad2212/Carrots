//
//  ingredientsTableController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/24/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

class ingredientsTableController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var recipeIngredientList:[ingredientItem] = []
    var boolIngredientList:[Bool] = []
    
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var ingredientTable: UITableView!
    
    var recipeObj:recipe?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        ingredientTable.reloadData()
        
        boolIngredientList = SQLiteDB.instance.returnMissingBooleanArray(inputID: Int(recipeObj!.id))
        recipeIngredientList =  SQLiteDB.instance.getIngredients(recipeID: recipeObj!.id)
        
        recipeTitle.text = recipeObj?.name
        
        print(boolIngredientList)
        //Getting data back from database
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //Todo: DATABASE LOADING HERE
        boolIngredientList = SQLiteDB.instance.returnMissingBooleanArray(inputID: Int(recipeObj!.id))
        recipeIngredientList =  SQLiteDB.instance.getIngredients(recipeID: recipeObj!.id)
        
        ingredientTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return recipeList.count
        return recipeIngredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "newIngridientCell", for: indexPath) as! newIngredientCell
            
            cell.ingredientName?.text = recipeIngredientList[indexPath.row].name
            cell.ingredientCount?.text = String(recipeIngredientList[indexPath.row].count)
            cell.ingredientMeasurementType?.text = recipeIngredientList[indexPath.row].measurementType
            if(boolIngredientList[indexPath.row] == false)
            {
                cell.checkBoxImage.image = #imageLiteral(resourceName: "crossBox") ;
            }
            else
            {
                cell.checkBoxImage.image = #imageLiteral(resourceName: "checkBox") ;
            }
            
            
            
            
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
             let myIngredient = recipeIngredientList[indexPath.row]
             if (SQLiteDB.instance.deleteIngredientID(cid: myIngredient.id, name: myIngredient.name))
             {
                boolIngredientList = SQLiteDB.instance.returnMissingBooleanArray(inputID: Int(recipeObj!.id))
                recipeIngredientList =  SQLiteDB.instance.getIngredients(recipeID: recipeObj!.id)
                ingredientTable.reloadData()
             }
            
            
            
        }
    }
    

    
}
