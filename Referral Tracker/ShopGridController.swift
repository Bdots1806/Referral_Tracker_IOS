//
//  ViewController.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-09.
//

import UIKit

class ShopGridController: UIViewController {
    var save = PicStore()
    var pics = [Pic]()
    
    override func viewWillDisappear(_ animated: Bool) {
        //let rootViewController = window!.rootViewController? as! UINavigationController
        //let ShopGridController = rootViewController.topViewController as! ShopGridController
        //ShopGridController.save = PicStore()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //getAllPics(pics)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
 @IBAction func getAllPics(_ sender: Any) {
        save.getAllPics {(picsResult)->Void in
            switch picsResult {
            case let .success(pics):
                self.pics = pics
                self.myCollectionView.reloadData()
               // print("get all pics success!")
            case let .failure(error):
                print("Error fetching pics \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "singlePic"?:
            if let selectedIndexPath =
                myCollectionView.indexPathsForSelectedItems?.first {
                let pic = pics[selectedIndexPath.row]
                let destinationVC = segue.destination as!
                 OrderViewController
                destinationVC.pic = pic
                destinationVC.save = save
            }
        default:
            preconditionFailure("Unexpected segue ID")
        }
    }
}

extension ShopGridController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "ShopGridCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ShopGridCell
        return cell
    }
}

extension ShopGridController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let picIndex = indexPath.row
        let pic = pics[picIndex]
        //print("In mainVC entered above fetch...")
        save.fetchImage(for: pic) { (result)->Void in
            guard let picIndex = self.pics.firstIndex(of: pic),
                  case let .success(image) = result
            else {
                return
            }
            let picIndexPath = IndexPath(item: picIndex, section: 0)
            if let cell = self.myCollectionView.cellForItem(at: picIndexPath) as? ShopGridCell {
                //print("Entered above cell update...")
                cell.update(with: image)
            }
        }
    }
}



