//
//  ChoiceViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit

class ChoiceViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        signUpButton.makeBorderRounded(10,2,UIColor(named: "appColor")!.cgColor)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

extension UIView {
    
    func makeBorderRounded(_ raduis : CGFloat, _ borderWidth : CGFloat, _ color: CGColor){
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = raduis
        self.clipsToBounds = true
        self.layer.borderColor = color
        self.layer.borderWidth = borderWidth
    }
    
}
