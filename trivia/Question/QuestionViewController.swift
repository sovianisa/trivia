//
//  QuestionViewController.swift
//  trivia
//
//  Created by Annisa Sofia Noviantina on 1/9/18.
//  Copyright © 2018 Annisa Sofia Noviantina. All rights reserved.
//

import UIKit
import RealmSwift

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var rightAnswerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var dView: UIView!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var aRoundView: UIView!
    @IBOutlet weak var bRoundView: UIView!
    @IBOutlet weak var cRoundView: UIView!
    @IBOutlet weak var dRoundView: UIView!
    @IBOutlet weak var aAnswerLabel: UILabel!
    @IBOutlet weak var bAnswerLabel: UILabel!
    @IBOutlet weak var cAnswerLabel: UILabel!
    @IBOutlet weak var dAnswerLabel: UILabel!
    @IBOutlet weak var aResultLabel: UILabel!
    @IBOutlet weak var bResultLabel: UILabel!
    @IBOutlet weak var cResultLabel: UILabel!
    @IBOutlet weak var dResultLabel: UILabel!
    
    var questionArray = [Results<Question>]()
    var titleCategory = " "
    var currentNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
    


}
