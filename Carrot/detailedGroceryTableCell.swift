//
//  detailedGroceryTableCell.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/23/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
class detailedGroceryTableCell: UITableViewCell {
    
    //the detailed grocery cell
    weak var delegate: UISearchBarDelegate?
    
    @IBOutlet var itemPurchasedDate: UILabel!
    @IBOutlet var itemLocation: UILabel!
    @IBOutlet var itemExpiringDate: UILabel!
    @IBOutlet var itemCount: UILabel!
    
}
