//
//  Question.swift
//  trivia
//
//  Created by Annisa Sofia Noviantina on 1/9/18.
//  Copyright © 2018 Annisa Sofia Noviantina. All rights reserved.
//

import UIKit
import RealmSwift

class Question: Object {
    @objc dynamic var question = ""
    @objc dynamic var a = ""
    @objc dynamic var b = ""
    @objc dynamic var c = ""
    @objc dynamic var d = ""
    @objc dynamic var correctanswer = ""
    @objc dynamic var answer = ""
}
