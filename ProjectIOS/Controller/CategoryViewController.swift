//
//  CategoryViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController {
    @IBOutlet weak var Category_Image: UIImageView!
    @IBOutlet weak var Category_Name: UILabel!
    
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    
    var recipes = [Recipe]()
    
    var category:Category?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let category = self.category{
            self.Category_Name.text = category.Category_Name
            
            self.Category_Image.image = UIImage(named: category.Category_Image)!
            self.Category_Image.contentMode = .scaleAspectFill
            
            recipeCollectionView.dataSource = self
            
          //  recipeCollectionView.delegate = self
            getRecipes()
            
            
        }

        // Do any additional setup after loading the view.
    }
    
    func getRecipes(){
        
       
        db.collection("recipe").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var recipe :Recipe
                    
                    let id = document.documentID as String
                    let data = document.data()
                    let name = data["name"] as! String
                    let ingrdients = data["ingredients"] as! String
                    let steps = data["steps"] as! String
                    let image = data["image"] as! String
                    let categoryName = data["categoryName"] as! String
                    let userId = data["userId"] as! String
                    
                  //  let imageData = Data(image.utf8)
                    
                    
                    recipe = Recipe(id :id,
                    name :name,
                    image : image,
                    ingredients :ingrdients,
                    steps : steps,
                    cetgoryName :categoryName,
                    userId : Int(userId)!)
                    
                    self.recipes.append(recipe)
                    print("\(document.documentID) => \(document.data()["name"] as! String)")
                }
            }
        }
    }
 
}


//extension CategoryViewController : UICollectionViewDataSource{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return recipes.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCollectionViewCell
//    }
//
//
//}

extension CategoryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCollectionViewCell
        
        
        cell.configure(recipeImage: UIImage(data:
                                                Data(
                                    (recipes[indexPath.item].image).utf8
                                )
        )!
                ,recipeName:recipes[indexPath.item].name)
        return cell
    }
}

