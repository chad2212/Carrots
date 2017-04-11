//
//  GroceryController.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
class GroceryController: UIViewController {
    
    var toPass: groceryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if((toPass?.title) != nil){
            //We load the Database here based on the title
        }
        // Do view setup here.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
