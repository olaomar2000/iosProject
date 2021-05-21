//
//  EditProfileViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit
import CoreData

class EditProfileViewController: UIViewController {

    
    @IBOutlet weak var editProfileImage: UIImageView!
    
    @IBOutlet weak var editUsernameTXT: UITextField!
    
    @IBOutlet weak var editEmailTXT: UITextField!
    
    let id = UserDefaults.standard.integer(forKey: "id") as NSNumber
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editUsernameTXT.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        editEmailTXT.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        
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
                    editEmailTXT.text = user.email
                    editUsernameTXT.text = user.username
                    
                    if (user.imageUser != nil) {
                        
                        editProfileImage.image = UIImage(data: user.imageUser!)
                        editProfileImage.makeRounded()
                        
                    }
                    
                }
                
            }
        }
        catch
        {
            print("Fetch Failed")
        }
        
    }
    
    @IBAction func doneButton(_ sender: Any) {
        
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
                    user.email = editEmailTXT.text
                    user.username = editUsernameTXT.text
                    
                    if let imageData = editProfileImage.image?.pngData() {
                        user.imageUser = imageData
                    }
                    
                    try context.save()
                    let storyBoard = UIStoryboard(name: "Main", bundle: .main)
                    let vc = storyBoard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                    vc.selectedIndex = 2
                    navigationController?.show(vc, sender: self)
                    navigationController?.setNavigationBarHidden(true, animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
        
    }
    
    
    @IBAction func changeImageButton(_ sender: Any) {
        
        let alert = UIAlertController(title:"Profile Image", message:"Please choose the source of your profile image", preferredStyle: .actionSheet)
              
              
              let okAction = UIAlertAction(title:"Photo Album", style: .default, handler: { action in
                  let imagePicker = UIImagePickerController()
                  imagePicker.sourceType = .photoLibrary
                  imagePicker.delegate = self
                  DispatchQueue.main.async {
                      self.present(imagePicker, animated: true, completion: nil)
                  }
                                          
              })
                                      
              alert.addAction(okAction)
              
              alert.addAction(UIAlertAction(title:"Camera", style: .default, handler: { (action) in
                  
              }))
              
              alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
                                      
              self.present(alert, animated: true, completion: nil)
          }
    
}


extension EditProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("You canceled the operation")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        editProfileImage.image = (info[.originalImage] as! UIImage)
        editProfileImage.makeRounded()
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
