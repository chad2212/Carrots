//
//  newGroceryItem.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit

class newGroceryItemController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToList", sender: self)
    }
    

}
