//
//  recipeNameController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

class recipeNameController : UIViewController{
    
    var recipeObj:recipe?

    
    @IBOutlet var recipeNameField: UITextField!
    
    @IBAction func createRecipe(_ sender: UIButton) {
        let id = SQLiteDB.instance.addRecipe(addName: self.recipeNameField.text!)
        let list:[ingredientItem] = []
        recipeObj = recipe(id: id!, name: self.recipeNameField.text!, ingredientList: list)
        print("Going to the ingridient adding page")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toAddIngridientSegue"){
            print("Inside segue controller to pass obj")
            let svc = segue.destination as! newIngredientController
            svc.receivedRecipeObj = recipeObj
        }
    }
}
