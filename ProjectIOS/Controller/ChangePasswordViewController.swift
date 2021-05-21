//
//  ChangePasswordViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit
import CoreData

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var currentPasswordTXT: UITextField!
    @IBOutlet weak var newPasswordTXT: UITextField!
    @IBOutlet weak var newPasswordAgainTXT: UITextField!
    
    let id = UserDefaults.standard.integer(forKey: "id") as NSNumber
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPasswordTXT.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        newPasswordTXT.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        newPasswordAgainTXT.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        do {
            request.returnsObjectsAsFaults = false
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let user = result as! User
                if (user.id == id) {
                    
                    if (user.password == currentPasswordTXT.text) {
                        
                        if (newPasswordTXT.text == newPasswordAgainTXT.text) {
                            user.password = newPasswordTXT.text
                            try context.save()
                            navigationController?.popViewController(animated: true)
                        }else{
                            self.showToast(message: "Two passwords doesn't match🙁", font: .systemFont(ofSize: 14.0))
                        }
                    }else{
                        self.showToast(message: "Incorrect password🙁", font: .systemFont(ofSize: 14.0))
                    }
                    
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
        
    }
    
}
