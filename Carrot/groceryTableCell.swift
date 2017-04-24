//
//  groceryTableCell.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import UIKit
class groceryTableCell: UITableViewCell {
    weak var delegate: UISearchBarDelegate?
    
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemNumber: UILabel!
    
    @IBOutlet var itemLocation: UILabel!
}
