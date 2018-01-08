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
        
        return realm.objects(Category.self)
    }
    
    class func loadQuestionsFromJSON(json: JSON) -> Results<Question> {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(Question.self))
        }
        
        guard let questions = json["results"].array
            else {
                print("No array")
                return realm.objects(Question.self)
        }
        
        for question in questions {
            guard let quest = question["question"].string,
                let a = question["correct_answer"].string,
                let incorrect = (question["incorrect_answers"]).array,
                let b = incorrect[0].string,
                let c = incorrect[1].string,
                let d = incorrect[2].string,
                let correct = question["correct_answer"].string
                else {
                    print("Error with data")
                    return realm.objects(Question.self)
            }
            
            let question =  Question(value: [quest,a,b,c,d, correct,""])
            try! realm.write {
                realm.add(question)
            }
            
        }
        
        return realm.objects(Question.self)
    }
    
    class func loadCategoryFromLocal() -> Results<Category> {
        let realm = try! Realm()
        return realm.objects(Category.self)
        
    }
    
    class func loadQuestionFromLocal() -> Results<Question> {
        let realm = try! Realm()
        return realm.objects(Question.self)
        
    }
}

