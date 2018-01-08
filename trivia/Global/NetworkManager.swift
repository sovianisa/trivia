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
    func dataReceived(data: Any?, error: NSError?)
}

class NetworkManager: NSObject {
    let baseURLString: String = "https://opentdb.com/"
    var baseURLWithAPIKeyString: String
    var delegate: NetworkManagerDelegate?
    
    override init() {
        self.baseURLWithAPIKeyString = "\(self.baseURLString)/"
        super.init()
    }
    
    func getCategory() {
        let requestURL: String = "\(baseURLWithAPIKeyString)api_category.php/"
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let json = response.result.value else {
                    return
                }
                self.delegate?.dataReceived(data: json, error: nil)
            case .failure(let error):
                self.delegate?.dataReceived(data: nil, error: error as NSError)
            }
        }
    }
}

