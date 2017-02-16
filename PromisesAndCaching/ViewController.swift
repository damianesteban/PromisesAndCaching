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

//    case .posts:
//    return "/posts/1"
//    case .albums:
//    return "/albums/1"
//    case .todos:
//    return "/todos/1"
//    case .users:
//    return "/users/1"
//}

    let s = NetworkService()
    let ed: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        s.fetchOne(dictionary: ed)
            .then(s.fetchTwo)
            .then(s.fetchThree)
            .then(s.fetchFour)
            // Add parseObject, writeToRealm
            .onError { e in
                print(e)
            }.finally {
                print("done")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func logDone() {
        print("done")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

