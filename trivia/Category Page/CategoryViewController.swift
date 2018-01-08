//
//  CategoryViewController.swift
//  trivia
//
//  Created by Annisa Sofia Noviantina on 1/8/18.
//  Copyright © 2018 Annisa Sofia Noviantina. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import SwiftSpinner

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NetworkManagerDelegate {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        
        loadCategory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = Utilities.navigationColor()
        navigationItem.title = "Select Category"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    func loadCategory(){
        categories = Utilities.loadCategoryFromLocal()
        if let categories = categories{
            if categories.count == 0 {
                let networkManager = NetworkManager()
                networkManager.delegate = self
                SwiftSpinner.show("Get Categories...")
                networkManager.getCategory()
            } else {
                categoryCollectionView.reloadData()
            }
        }
    }
    
    func dataReceived(data: Any?, error: NSError?) {
        SwiftSpinner.hide()
        if error != nil {
            print("Error: \(error as Optional)")
        }
        
        guard let data = data else {
            print("Error: No data")
            return
        }
        let json = JSON(data)
        categories = Utilities.loadCategoryFromJSON(json: json)
        categoryCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let categories = categories{
            return categories.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        if let categories = categories{
            let category = categories[indexPath.row]
            cell.categoryLabel.text = category.name;
        }
        
        return cell
    }
    
    
}

