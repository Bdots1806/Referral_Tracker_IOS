//
//  ViewController.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-09.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var myTitle: UILabel!
    
    @IBOutlet weak var myPic: UIImageView!
    
    @IBOutlet weak var myPrice: UILabel!
    
    var save : PicStore!
    
    var pic : Pic!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTitle.text = pic.title
        myPrice.text = String(pic.price) 
        save.fetchImage(for: pic) {
            (result)-> Void in switch(result) {
            case let .success(image):
                self.myPic.image = image
            case let .failure(error):
                print("Error fetching image for pic: \(error)")
            }
        }
    }


}

