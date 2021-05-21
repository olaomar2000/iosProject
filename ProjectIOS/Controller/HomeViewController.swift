//
//  HomeViewController.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var HomeCategory_TableView: UITableView!
    
    
    let data = [
    Category( Category_Image:"American",Category_Name: "American"),
    Category(Category_Image: "Mediterranean", Category_Name: "Mediterranean"),
    Category(Category_Image: "Mexican", Category_Name: "Mexican"),
    Category(Category_Image: "Italian", Category_Name: "Italian"),
    Category(Category_Image: "Greek", Category_Name: "Greek"),
    Category(Category_Image: "Asian", Category_Name: "Asian")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HomeCategory_TableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        HomeCategory_TableView.dataSource = self
        HomeCategory_TableView.delegate = self
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}


//MARK:- DATA SOURCE
extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        
        
        /*cell.configure(categoryImage: UIImage(named: data[indexPath.row].Category_Image)!, categoryName:  data[indexPath.row].Category_Name)*/
        
        cell.categoryImage.image = UIImage(named: data[indexPath.row].Category_Image)
        cell.categoryNameLabel.text = data[indexPath.row].Category_Name
        cell.categoryImage.contentMode = .scaleAspectFill
        
        
        return cell
    }
}

//MARK:- DELEGATE
extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = data[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard?.instantiateViewController(identifier: "Category") as! CategoryViewController
        vc.category = obj
        navigationController?.show(vc, sender: self)
    }
}
