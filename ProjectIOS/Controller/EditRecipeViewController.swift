//
//  EditRecipeViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit

class EditRecipeViewController: UIViewController {

    @IBOutlet weak var Delete_btn: UIButton!
    @IBOutlet weak var Steps_TF: UITextView!
    @IBOutlet weak var RecipeName_TF: UITextField!
    @IBOutlet weak var Ingredient_TF: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Delete_btn.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        Steps_TF.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        RecipeName_TF.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        Ingredient_TF.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
    }
    


}
