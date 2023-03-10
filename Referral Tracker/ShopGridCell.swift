//
//  PicCollectionViewCell.swift
//  Assignment_5
//
//  Created by Manan Patel on 11/26/22.
//

import UIKit

class ShopGridCell : UICollectionViewCell {
    //@IBOutlet var title: UILabel!
    @IBOutlet var imageView: UIImageView!
   
    @IBOutlet weak var loader: UIActivityIndicatorView!
    //@IBOutlet var price: UILabel!
    
    func update(with image: UIImage?) {
        if let displayImage = image {
            loader.stopAnimating()
            loader.hidesWhenStopped = true
            imageView.image = displayImage
        } else {
            loader.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
    
}
