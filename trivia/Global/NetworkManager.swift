//
//  NetworkManager.swift
//  trivia
//
//  Created by Annisa Sofia Noviantina on 1/8/18.
//  Copyright © 2018 Annisa Sofia Noviantina. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerDelegate {
    func dataCategoryReceived(data: Any?, error: NSError?)
    func dataQuestionsReceived(data: Any?, error: NSError?)
}

class NetworkManager: NSObject {
    let baseURLString: String = "https://opentdb.com"
    var baseURLWithAPIKeyString: String
    var delegate: NetworkManagerDelegate?
    
    override init() {
        self.baseURLWithAPIKeyString = "\(self.baseURLString)/"
        super.init()
    }
    
    func getCategory() {
        let requestURL: String =  "\(baseURLWithAPIKeyString)/api_category.php/"
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let json = response.result.value else {
                    return
                }
                self.delegate?.dataCategoryReceived(data: json, error: nil)
            case .failure(let error):
                self.delegate?.dataCategoryReceived(data: nil, error: error as NSError)
            }
        }
    }
    
    func getQuestions(category:Int) {
        
        let numbers :(Int) = Utilities.numberOfQuestions()
        let requestURL: String = "\(baseURLWithAPIKeyString)api.php?amount=\(numbers)&category=\(category)&difficulty=easy&type=multiple"
        print(requestURL)
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let json = response.result.value else {
                    return
                }
                self.delegate?.dataQuestionsReceived(data: json, error: nil)
            case .failure(let error):
                self.delegate?.dataQuestionsReceived(data: nil, error: error as NSError)
            }
        }
    }
}

