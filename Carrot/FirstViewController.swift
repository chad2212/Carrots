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

    var allGroceries = [groceryItem]()
    
    override func viewDidLoad() {
        
        allGroceries.append(groceryItem(title:"Meat",image:#imageLiteral(resourceName: "meat")))
        allGroceries.append(groceryItem(title:"Produce",image:#imageLiteral(resourceName: "produce")))
        allGroceries.append(groceryItem(title:"Dairy",image:#imageLiteral(resourceName: "dairy")))
        allGroceries.append(groceryItem(title:"Others",image:#imageLiteral(resourceName: "other")))
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groceryCell", for: indexPath) as! groceryCell
        if(indexPath.row < allGroceries.count){
            let data = allGroceries[indexPath.row]
            cell.groceryImage.clipsToBounds = true
            cell.groceryImage.image = data.image
            cell.groceryTitle.text = data.title
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if(segue.identifier == "segueGrocery"){
            let svc = segue.destination as! GroceryController
            let indexPath = Groceries.indexPath(for: sender as! groceryCell)
            print(indexPath!.row)
            print(allGroceries[indexPath!.row].title)
            svc.toPass = allGroceries[indexPath!.row]
        }
    }
    


    func searchList()
    {
        
    }
}

