//
//  FirstViewController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit



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
}

