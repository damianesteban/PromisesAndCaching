//
//  ViewController.swift
//  PromisesAndCaching
//
//  Created by Damian Esteban on 2/11/17.
//  Copyright © 2017 Damian Esteban. All rights reserved.
//

import UIKit
import then

class ViewController: UIViewController {

    let service = NetworkService()    
    let emptyDictionary: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.fetchOne(dictionary: emptyDictionary)
            .then(service.fetchTwo)
            .then(service.fetchThree)
            .then(service.fetchFour)
            .then(service.model)
            //// Add writeToRealm
            .onError { e in
                print(e)
            }.finally {
                print("done")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

