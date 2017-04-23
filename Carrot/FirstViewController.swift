//
//  FirstViewController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
import SQLite


class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var Groceries: UICollectionView!

    var allGroceryTypes = [groceryType]()
    
    override func viewDidLoad() {
        
        
                
        allGroceryTypes.append(groceryType(title:"Meat",image:#imageLiteral(resourceName: "meat")))
        allGroceryTypes.append(groceryType(title:"Produce",image:#imageLiteral(resourceName: "produce")))
        allGroceryTypes.append(groceryType(title:"Dairy",image:#imageLiteral(resourceName: "dairy")))
        allGroceryTypes.append(groceryType(title:"Others",image:#imageLiteral(resourceName: "other")))
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Groceries.delegate = self
        Groceries.dataSource = self
        Groceries.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groceryTypeCell", for: indexPath) as! groceryTypeCell
        if(indexPath.row < allGroceryTypes.count){
            let data = allGroceryTypes[indexPath.row]
            cell.groceryImage.clipsToBounds = true
            cell.groceryImage.image = data.image
            cell.groceryTitle.text = data.title
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if(segue.identifier == "segueGrocery"){
            let svc = segue.destination as! GroceryController
            let indexPath = Groceries.indexPath(for: sender as! groceryTypeCell)
            svc.toPass = allGroceryTypes[indexPath!.row]
        }
    }
    


    func searchList()
    {
        
    }
    
    /*
    func initialCreateTable() -> Connection?
    {
        
        print("creating table")
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try? Connection("\(path)/db.sqlite3")
        
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let count = Expression<Double>("count")
        let storedLocation = Expression<Bool>("storedLocation")
        let purchasedDate = Expression<String>("purchasedDate")
        let expiringDate = Expression<String>("expiringDate")
        let foodType = Expression<String>("foodType")
        
        
        do {
            try db?.run(foods.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(name)  //     "email" TEXT UNIQUE NOT NULL,
                t.column(count)                 //     "name" TEXT
                t.column(storedLocation)
                t.column(purchasedDate)
                t.column(expiringDate)
                t.column(foodType)
            })
            print("Table Successfully created")
        } catch{
            print("Table not created")
        }
        print("done creating a table")
        return db
 
    }*/
    
}

