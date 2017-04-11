//
//  groceryCell.swift
//  Carrot
//
//  Created by Shungheon Chai on 4/11/17.
//  Copyright © 2017 Chad Chai. All rights reserved.
//

import Foundation
import UIKit
class groceryCell: UICollectionViewCell {
    weak var delegate: UISearchBarDelegate?
    @IBOutlet weak var groceryImage: UIImageView!
    @IBOutlet weak var groceryTitle: UILabel!
}
