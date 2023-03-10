//
//  ViewController.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-09.
//

import UIKit
import CoreData

class RegisterController: UIViewController {
    
    var userlist = [Users]()
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var cPassword: UITextField!
    @IBOutlet weak var pRefferal: UITextField!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        if userName.isFirstResponder {
            userName.resignFirstResponder()
        }
        else if passWord.isFirstResponder {
            passWord.resignFirstResponder()
        }
        else if cPassword.isFirstResponder {
            cPassword.resignFirstResponder()
        }
        else if pRefferal.isFirstResponder {
            pRefferal.resignFirstResponder()
        }
    }
    
    @IBAction func clickReg(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = Users(entity: entity!, insertInto: context)
        
        newUser.id = Int32(userlist.count as NSNumber)
        newUser.username = userName.text
        newUser.password = passWord.text
        newUser.rCode = pRefferal.text
        if(pRefferal.text == " "){
            newUser.uPoint = 500
        }
        else{
            newUser.uPoint = 1000
        }
        do
                    {
                        
                        try context.save()
                        userlist.append(newUser)
                        navigationController?.popViewController(animated: true)
                    }
                    catch
                    {
                        print("context save error")
                    }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//    if segue.destination is DashboardController {
    let vc = segue.destination as? DashboardController
    if vc != nil {
        vc?.userNameValue = userName.text
        vc?.myPointsValue = "500"
        vc?.myReferralCode = "abc123"
//        vc?.myPoints.text = "500"
//        vc?.pReferralCode.text = "x2y1z"
    }
        
//    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

