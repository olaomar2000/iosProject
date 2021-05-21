//
//  SignUpViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit
import CoreData

//var userList = [User]()

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        passwordLabel.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        usernameLabel.makeBorderRounded(10,2, UIColor(named: "appColor")!.cgColor)
        signUp.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        
        emailLabel.delegate = self
        passwordLabel.delegate = self
        usernameLabel.delegate = self
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
           
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

                let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
                let newUser = User(entity: entity!, insertInto: context)
        
        if (!usernameLabel.text!.isEmpty && !emailLabel.text!.isEmpty && !passwordLabel.text!.isEmpty) {
            
            newUser.id = Int.random(in: 1..<1000000) as NSNumber
            newUser.username = usernameLabel.text
            newUser.email = emailLabel.text
            newUser.password = passwordLabel.text
            newUser.imageUser = nil
            
                    do
                    {
                        try context.save()
                        UserDefaults.standard.setValue(newUser.id, forKey: "id")
                        print("sign up")
                        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
                        let vc = storyBoard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                        
                        navigationController?.show(vc, sender: self)
                        
                    }
                    catch
                    {
                        print("context save error")
                    }
            
        }else{
            self.showToast(message: "Please fill all fields😀", font: .systemFont(ofSize: 14.0))
        }
       
 
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

extension SignUpViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
