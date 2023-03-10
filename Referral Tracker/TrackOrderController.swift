//
//  ViewController.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-09.
//

import UIKit
import MapKit

class TrackOrderController: UIViewController,UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,previewProvider: nil,actionProvider: {allowedAction in return self.contextMD()})
    }
    
    
    func contextMD() -> UIMenu{
        let sdMap = UIAction(title: NSLocalizedString("Standard Map", comment: "Standard view"), image: nil){
            action in self.myMap?.mapType = .standard
        }
        
        let stMap = UIAction(title: NSLocalizedString("Satellite Map", comment: "Satellite view"), image: nil){
            action in self.myMap?.mapType = .satellite
        }
        
        let hdMap = UIAction(title: NSLocalizedString("Hybrid Map", comment: "Hybrid view"), image: nil){
            action in self.myMap?.mapType = .hybrid
        }
        
        return UIMenu(title: NSLocalizedString("Map Types", comment: "maptypes"),children: [sdMap,stMap,hdMap])
    }
    

    override func viewDidLoad() {
        let mapInteraction = UIContextMenuInteraction(delegate: self)
        myMap?.addInteraction(mapInteraction)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var myMap: MKMapView!
    
    
    
}

