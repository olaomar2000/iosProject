//
//  ProfileViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//


import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var Edit_Profile_btn :UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       Edit_Profile_btn.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        

        let id = UserDefaults.standard.integer(forKey: "id") as NSNumber
        
        
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
                    profileUsernameLabel.text = user.username
                    
                    if (user.imageUser != nil) {
                        
                        profileImage.image = UIImage(data: user.imageUser!)
                        profileImage.makeRounded()
                        
                        
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

extension UIImageView {
    
    func makeRounded(){
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}
