//
//  SignInViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var passwordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        passwordLabel.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        signIn.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        
        self.emailLabel.delegate = self
        self.passwordLabel.delegate = self
        
        
    }
    


    @IBAction func signInButton(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        if (!emailLabel.text!.isEmpty && !passwordLabel.text!.isEmpty) {
            
            do {
                request.returnsObjectsAsFaults = false
                let results:NSArray = try context.fetch(request) as NSArray
                print(results)
                for result in results
                {
                    let user = result as! User
                    if (user.email == emailLabel.text) {
                        if (user.password == passwordLabel.text) {
                            
                            UserDefaults.standard.setValue(user.id, forKey: "id")
                            
                            let storyBoard = UIStoryboard(name: "Main", bundle: .main)
                            let vc = storyBoard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                            
                            navigationController?.show(vc, sender: self)
                            
                        }else{
                            self.showToast(message: "Incorrect password🙁", font: .systemFont(ofSize: 14.0))
                        }
                    }else{
                        self.showToast(message: "Incorrect email🙁", font: .systemFont(ofSize: 14.0))                    }
                    
                    }
            }
            catch
            {
                print("Fetch Failed")
            }
            
        }else{
            self.showToast(message: "Please fill all fields😀", font: .systemFont(ofSize: 12.0))
        }
        
        
    }
    
}

extension SignInViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
