//
//  ShopListCell.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-10.
//

import UIKit

class ShopListCell: UITableViewCell{
    
    @IBOutlet var itemName: UILabel!
   // @IBOutlet var pic: UIImageView!
    @IBOutlet var itemPrice: UILabel!
    
    override func awakeFromNib() {
        itemName.adjustsFontForContentSizeCategory = true
        itemPrice.adjustsFontForContentSizeCategory = true
        
    }
    
}
