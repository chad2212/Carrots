//
//  newingredientController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

class newIngredientController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var recipeTitleIngredients: UILabel!
    
    @IBOutlet var ingredientNameField: UITextField!
    @IBOutlet var ingredientCountField: UITextField!
    @IBOutlet var ingredientMeasurementTypeField: UITextField!
    
    var receivedRecipeObj: recipe?
    var ingredientList:[ingredientItem] = []
    
    @IBOutlet var ingredientTable: UITableView!
    
    @IBAction func addIngredient(_ sender: UIButton) {
        //add it to the database, reload the ingredientList, then reloadTheTable
        let nameInput = self.ingredientNameField.text
        let countInput = self.ingredientCountField.text
        let measurementInput = self.ingredientMeasurementTypeField.text
        
        SQLiteDB.instance.addIngredient(addRecipeID: (receivedRecipeObj?.id)!, addIngredientName: nameInput!, addIngredientCount: Int64(countInput!)!, addMeasurementType: measurementInput!)
        ingredientList = SQLiteDB.instance.getIngredients(recipeID: (receivedRecipeObj?.id)!)
        ingredientTable.reloadData()
        ingredientNameField.text = ""
        ingredientCountField.text = ""
        ingredientMeasurementTypeField.text = ""
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if((receivedRecipeObj?.name) != nil){
            //Load the database here based on the title
            self.recipeTitleIngredients.text = receivedRecipeObj?.name
        }
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        ingredientTable.reloadData()
        
        
        
        
        //Getting data back from database
        
    }
    override func viewDidAppear(_ animated: Bool) {
        ingredientList = SQLiteDB.instance.getIngredients(recipeID: (receivedRecipeObj?.id)!)
        ingredientTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print (ingredientList)
        
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! ingredientCell
            
            cell.ingredientName?.text = ingredientList[indexPath.row].name
            cell.ingredientCount?.text = String(ingredientList[indexPath.row].count)
            cell.ingredientMeasurementType?.text = ingredientList[indexPath.row].measurementType
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            
            let myIngredient = ingredientList[indexPath.row]
            if (SQLiteDB.instance.deleteIngredientID(cid: myIngredient.id, name: myIngredient.name))
            {
                ingredientList = SQLiteDB.instance.getIngredients(recipeID: (receivedRecipeObj?.id)!)
                ingredientTable.reloadData()
            }
            
            
        }
        
        
    }
    
    @IBAction func backToRecipeTable(_ sender: Any) {
        performSegue(withIdentifier: "unwindToRecipeTable", sender: self)
    }

}
