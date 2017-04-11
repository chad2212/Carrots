//
//  GroceryController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

var localGroceryList:[groceryItem] = []

class GroceryController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var groceryItemized: UITableView!
    @IBOutlet var groceryType: UILabel!
    
    @IBAction func unwindToList(segue:UIStoryboardSegue) { }
    
    var toPass: groceryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of:toPass))
        if((toPass?.title) != nil){
            //We load the Database here based on the title
            self.groceryType.text = toPass?.title
        }
        groceryItemized.delegate = self
        groceryItemized.dataSource = self
        groceryItemized.reloadData()
        // Do view setup here.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        groceryItemized.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localGroceryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemizedCell", for: indexPath)
            cell.textLabel?.text = localGroceryList[indexPath.row].title
            /*
            if localMovieArray.isEmpty{
                self.favoriteMovies.isHidden = true
                self.noFavorites.isHidden = false
            }
            else{
                self.favoriteMovies.isHidden = false
                self.noFavorites.isHidden = true
            }
            */
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row): \(localGroceryList[indexPath.row])")
    }
    
    func reloadFavoriteMovieData(newArr:[String]){
        //localGroceryList
        groceryItemized.reloadData()
    }
    
    func loadFromDB()
    {
        //to be implemented
    }

}
