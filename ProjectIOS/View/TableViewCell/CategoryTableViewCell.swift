//
//  CategoryTableViewCell.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds  = true
        categoryImage.layer.cornerRadius = 10
        categoryImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(categoryImage:UIImage,categoryName:String){
        self.categoryImage.image = categoryImage
        self.categoryImage.contentMode = .scaleAspectFill
        self.categoryNameLabel.text = categoryName
    }
    
}
