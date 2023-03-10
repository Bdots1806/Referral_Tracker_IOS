//
//  Pic.swift
//  Assignment_5
//
//  Created by Manan Patel on 11/26/22.
//

import UIKit

class Pic {
    let title: String
    let remoteURL: String
    let picID: Int
    let price: String
    
    init(id: Int, remoteURL: String, title: String, price: String) {
        self.title = title
        self.remoteURL = remoteURL
        self.picID = id
        self.price = price
    }
}

extension Pic : Equatable {
    static func == (lhs: Pic, rhs: Pic)->Bool {
        return lhs.picID == rhs.picID
    }
}
