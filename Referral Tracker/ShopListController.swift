//
//  ViewController.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-09.
//

import UIKit

class ShopListController: UITableViewController{
    
    var store = itemStore()
    
    @IBAction func getItems(_ sender: Any) {
        store.getAllitems { (itemResult)->Void in
            switch itemResult {
                case let .success(items):
                    self.iTems = items
                    self.tableView.reloadData()
                case let .failure(error):
                    print("Error fetching items \(error)")
            }
        }
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "singlePic"?:
            if let selectedIndexPath =
                ShopListCell.indexPathsForSelectedItems?.first {
                let pic = iTems[selectedIndexPath.row]
                let destinationVC = segue.destination as!
                 OrderViewController
                destinationVC.pic = pic
                //destinationVC.save = itemStore()
            }
        default:
            preconditionFailure("Unexpected segue ID")
        }
    }*/


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var iTems = [Shop]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iTems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ShopListViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ShopListCell
        let item = iTems[indexPath.row]
       // cell.id.text = String(item.id)
        cell.itemName.text = item.itemName
        cell.itemPrice.text = item.itemPrice
        return cell
    }


}

