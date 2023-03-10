//
//  shop.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-10.
//

import Foundation

class Shop {
    var id: Int
    var itemName: String
    var itemPrice: String
    
    init (id: Int, itemName: String, itemPrice: String){
        self.id = id
        self.itemName = itemName
        self.itemPrice = itemPrice
    }
}
