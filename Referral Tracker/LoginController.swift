//
//  ViewController.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-09.
//

import UIKit
import CoreData
class LoginController: UIViewController {
    
    @IBOutlet weak var myUsername: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        if myUsername.isFirstResponder {
            myUsername.resignFirstResponder()
        }
        else if myPassword.isFirstResponder {
            myPassword.resignFirstResponder()
        }
    }
    
    @IBAction func UnwindFromDashboard(segue: UIStoryboardSegue){
        print("bye")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
        if segue.destination is DashboardController {
        let vc = segue.destination as? DashboardController
            vc?.userNameValue = myUsername.text
            vc?.myPointsValue = "500"
            vc?.myReferralCode = "abc123"
//            vc?.myPoints.text = "500"
//            vc?.pReferralCode.text = "x2y1z"
        }
        }
    
    @IBAction func clickLogin(_ sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results{
                let r = result as! Users
                if(myUsername.text == r.username){
                    if(myPassword.text == r.password){
                        
                    }
                }
            }
            
        }
        catch{
            print("Fetch Failed")
        }
    }


}

