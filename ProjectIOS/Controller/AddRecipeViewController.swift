//
//  AddRecipeViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit
import Firebase
import FirebaseStorage



class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let fileName = NSUUID().uuidString
    let db = Firestore.firestore()
    let id = UserDefaults.standard.integer(forKey: "id")
    let storage = Storage.storage().reference()
    var imageUrl:Data?

    @IBOutlet weak var Rec_Steps_Add_TF: UITextView!
    @IBOutlet weak var Ingredients_Add_TF: UITextView!
    @IBOutlet weak var Rec_Name_Add_TF: UITextField!
    @IBOutlet weak var Rec_Image_Add: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Rec_Name_Add_TF.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        Rec_Steps_Add_TF.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        Ingredients_Add_TF.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        
        Rec_Name_Add_TF.delegate = self
        Rec_Steps_Add_TF.delegate = self
        Ingredients_Add_TF.delegate = self
        
        
        
  //MARK:- DropDown
        
      /*  let dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = view// UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
        }

        // Will set a custom width instead of the anchor view width
        dropDown.width = 200
        dropDown.show()
        dropDown.hide()
*/

    }
    
    
    @IBAction func save_add(_ sender: Any) {

        print("save")

        let name:String = Rec_Name_Add_TF.text!
        let ingredients:String = Ingredients_Add_TF.text
        let steps:String = Rec_Steps_Add_TF.text
        let image:String = String(decoding: imageUrl!, as: UTF8.self)
        let userId :String = String(id)
        
        if (!name.isEmpty && !ingredients.isEmpty && !steps.isEmpty && !image.isEmpty && !userId.isEmpty) {
            
            print("the data is correct")
            
            db.collection("rec").addDocument(data: [
                "name":"name",
                "ingredients":"ingredients",
                "steps":"steps"

            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with id")
                }
            }
            
            
            var ref: DocumentReference? = nil
            db.collection("recipe").addDocument(data:[
                "name":name,
                "ingredients":ingredients,
                "steps":steps,
                "image":image,
                "categoryName":"test",
                "userId":userId
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("successfully written")
                    self.tabBarController?.selectedIndex = 0
                }
            }

            
            
        }else{
            self.showToast(message: "Please fill all fields😀", font: .systemFont(ofSize: 14.0))
        }


    }
    
    
    @IBAction func add_image(_ sender: Any) {
        
        let alert = UIAlertController(title:"Recipe Image", message:"Please choose the source of your Recipe image", preferredStyle: .actionSheet)
              
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
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("You canceled the operation")
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let image = info[.originalImage] as! UIImage
            Rec_Image_Add.contentMode = .scaleAspectFill
            Rec_Image_Add.image = (image)
            picker.dismiss(animated: true, completion: nil)
        
            guard let imageData = image.pngData() else {return}
            imageUrl = imageData
        }
    
    
}

extension AddRecipeViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension AddRecipeViewController :  UITextViewDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

