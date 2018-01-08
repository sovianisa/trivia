//
//  Utilities.swift
//  trivia
//
//  Created by Annisa Sofia Noviantina on 1/8/18.
//  Copyright © 2018 Annisa Sofia Noviantina. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import SwiftHEXColors

class Utilities {
    
    class func navigationColor() -> UIColor {
        return UIColor(hexString: "#9012fe")!
    }
    
    class func loadCategoryFromJSON(json: JSON) -> Results<Category> {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(Category.self))
        }
        
        
        guard let categories = json["trivia_categories"].array
            else {
                print("No array")
                return realm.objects(Category.self)
        }
        
        for category in categories {
            guard let id = category["id"].int,
                let name = category["name"].string
                else {
                    print("Error with data")
                    return realm.objects(Category.self)
            }
            
            let category =  Category(value: [("\(id)"), name])
            try! realm.write {
                realm.add(category)
            }
            
        }
        
        let categoryArray = realm.objects(Category.self)
        
        return categoryArray
    }
    
    class func loadCategoryFromLocal() -> Results<Category> {
        let realm = try! Realm()
        let categoryArray = realm.objects(Category.self)
        return categoryArray
        
    }
}

