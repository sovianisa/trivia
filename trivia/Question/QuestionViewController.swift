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
    @IBOutlet weak var nextButton: UIButton!
    
    var questionArray = [Results<Question>]()
    var titleCategory = ""
    var currentNumber : Int = 1
    var recapRightAnswer = 0
    var correctAnswer = 1
    let questions = Utilities.loadQuestionFromLocal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setLayout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = Utilities.navigationColor()
        navigationItem.title = "\(titleCategory)"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let leftBtn = UIBarButtonItem(image: UIImage.init(named: "icon-close"), style: .plain, target: self, action: #selector(backToRoot))
        leftBtn.tintColor = UIColor.white
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = leftBtn
        self.navigationItem.hidesBackButton = true
    }
    
    func setLayout() {
        Utilities.addLineView(views: aView, color :UIColor.black)
        Utilities.addLineView(views: bView, color :UIColor.black)
        Utilities.addLineView(views: cView, color :UIColor.black)
        Utilities.addLineView(views: dView, color :UIColor.black)
        Utilities.addLineView(views: aRoundView,  color :UIColor.lightGray)
        Utilities.addLineView(views: bRoundView,  color :UIColor.lightGray)
        Utilities.addLineView(views: cRoundView,  color :UIColor.lightGray)
        Utilities.addLineView(views: dRoundView,  color :UIColor.lightGray)
        
        aButton.addTarget(self, action: #selector(buttonAnswerClicked(sender:)), for: UIControlEvents.touchUpInside)
        bButton.addTarget(self, action: #selector(buttonAnswerClicked(sender:)), for: UIControlEvents.touchUpInside)
        cButton.addTarget(self, action: #selector(buttonAnswerClicked(sender:)), for: UIControlEvents.touchUpInside)
        dButton.addTarget(self, action: #selector(buttonAnswerClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        questionNumberLabel.text = "Question no.\(currentNumber)"
        let defaults = UserDefaults.standard
        recapRightAnswer = defaults.value(forKey: "RecapCorrectAnswer") as! Int
        rightAnswerLabel.text = "\(recapRightAnswer) Right Answer"
        
        if questions.count > 0 {
            let quest = questions[currentNumber-1]
            questionLabel.text = quest.question.htmlDecoded()
            aAnswerLabel.text = quest.a
            bAnswerLabel.text = quest.b
            cAnswerLabel.text = quest.c
            dAnswerLabel.text = quest.d
            
        }
        let numberOfQuestion: Int = Utilities.numberOfQuestions()
        
        if(numberOfQuestion == currentNumber){
            nextButton.setTitle("FINISH", for: UIControlState.normal)
            nextButton.removeTarget(self, action: #selector(tapNextButton(_:)), for: UIControlEvents.touchUpInside)
            nextButton.addTarget(self, action: #selector(showAlert), for: UIControlEvents.touchUpInside)
        }
        
    }
    
    @objc func backToRoot(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Recaps", message: "You succesfully answer \(recapRightAnswer) from \(Utilities.numberOfQuestions())", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ Void in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapNextButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : QuestionViewController = storyboard.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        
        vc.titleCategory = titleCategory
        let defaults = UserDefaults.standard
        defaults.set(currentNumber+1, forKey: "CurrentNumber")
        vc.currentNumber = currentNumber+1;
        self.navigationController?.pushViewController(vc,animated: true )
    }
    
    @objc func buttonAnswerClicked(sender: UIButton) {
        if questions.count > 0 {
            let quest = questions[currentNumber-1]
            if (quest.a == quest.correctanswer) {
                correctAnswer = 1
                Utilities.viewRightColor(views: aView)
                aAnswerLabel.textColor = UIColor.white
                aResultLabel.isHidden = false
            } else if (quest.b == quest.correctanswer) {
                correctAnswer = 2
                Utilities.viewRightColor(views: bView)
                bAnswerLabel.textColor = UIColor.white
                bResultLabel.isHidden = false
            } else if (quest.c == quest.correctanswer) {
                correctAnswer = 3
                Utilities.viewRightColor(views: cView)
                cAnswerLabel.textColor = UIColor.white
                cResultLabel.isHidden = false
            } else {
                correctAnswer = 4
                Utilities.viewRightColor(views: dView)
                dAnswerLabel.textColor = UIColor.white
                dResultLabel.isHidden = false
            }
            
            
            if (sender.tag != correctAnswer) {
                if sender.tag == 1 {
                    Utilities.viewWrongColor(views: aView)
                    aAnswerLabel.textColor = UIColor.white
                    aResultLabel.isHidden = false
                    aResultLabel.text = "Wrong Answer!"
                } else if sender.tag == 2 {
                    Utilities.viewWrongColor(views: bView)
                    bAnswerLabel.textColor = UIColor.white
                    bResultLabel.isHidden = false
                    bResultLabel.text = "Wrong Answer!"
                } else if sender.tag == 3 {
                    Utilities.viewWrongColor(views: cView)
                    cAnswerLabel.textColor = UIColor.white
                    cResultLabel.isHidden = false
                    cResultLabel.text = "Wrong Answer!"
                } else {
                    Utilities.viewWrongColor(views: dView)
                    dAnswerLabel.textColor = UIColor.white
                    dResultLabel.isHidden = false
                    dResultLabel.text = "Wrong Answer!"
                }
            } else {
                
                let defaults = UserDefaults.standard
                recapRightAnswer = defaults.value(forKey: "RecapCorrectAnswer") as! Int
                recapRightAnswer = recapRightAnswer + 1
                defaults.set(recapRightAnswer, forKey: "RecapCorrectAnswer")
                rightAnswerLabel.text = "\(recapRightAnswer) Right Answer"
            }
            
            aButton.isEnabled = false
            bButton.isEnabled = false
            cButton.isEnabled = false
            dButton.isEnabled = false
            nextButton.isEnabled = true
            
        }
    }
    
    
}

extension String {
    func htmlDecoded()->String {
        
        guard (self != "") else { return self }
        
        var newStr = self
        let entities = [ //a dictionary of HTM/XML entities.
            "&#039;"    : "\"",
            "&quot;"    : "\"",
            "&amp;"     : "&",
            "&apos;"    : "'",
            "&lt;"      : "<",
            "&gt;"      : ">",
            "&deg;"     : "º",
            ]
        
        for (name,value) in entities {
            newStr = newStr.replacingOccurrences(of: name, with: value)
        }
        return newStr
    }
}


