//
//  RecipeCollectionViewCell.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(recipeImage:UIImage,recipeName:String){
        self.recipeImage.image = recipeImage
        self.recipeImage.contentMode = .scaleAspectFill
        self.recipeNameLabel.text = recipeName
    }

}

