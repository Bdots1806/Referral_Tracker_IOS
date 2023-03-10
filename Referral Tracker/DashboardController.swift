//
//  ViewController.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-09.
//

import UIKit
import CoreData
class DashboardController: UIViewController {
    
    var userlist = [Users]()
    
    var userNameValue : String!
    var myPointsValue : String!
    var myReferralCode : String!
    
    
    
    @IBOutlet weak var myPoints: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var referralCode: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = userNameValue
        myPoints.text = myPointsValue
        referralCode.text = myReferralCode
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
             let results:NSArray = try context.fetch(request) as NSArray
             for result in results
              {
                
               }
              }
               catch
               {
                print("Fetch Failed")
               }
    }

}

