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
    
    class func rightColor() -> UIColor {
        return UIColor(hexString: "#50e3c2")!
    }
    
    class func wrongColor() -> UIColor {
        return UIColor(hexString: "#fb4040")!
    }
    
    class func numberOfQuestions() -> Int {
        return 20
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
            
            let n = Int(arc4random_uniform(3))
            var question = Question()
            if (n == 0) {
                question = Question(value: [quest,a,b,c,d, correct,""])
            } else if (n == 1){
                question = Question(value: [quest,b,a,c,d, correct,""])
            } else if (n == 1){
                question = Question(value: [quest,b,c,a,d, correct,""])
            } else {
                question = Question(value: [quest,b,c,d,a, correct,""])
            }
            
            
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
    
    class func addLineView(views : UIView, color:UIColor) {
        views.layer.borderWidth = 1;
        views.layer.borderColor = color.cgColor
    }
    
    class func viewRightColor (views: UIView) {
        views.backgroundColor = rightColor()
        views.layer.borderColor = rightColor().cgColor
    }
    
    class func viewWrongColor (views: UIView) {
        views.backgroundColor = wrongColor()
        views.layer.borderColor = wrongColor().cgColor
    }
    
    class func viewNormalColor (views: UIView) {
        views.backgroundColor = UIColor.white
        views.layer.borderColor = UIColor.black.cgColor
    }
}

