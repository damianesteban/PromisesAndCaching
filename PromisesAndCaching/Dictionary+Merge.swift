//
//  Dictionary+Merge.swift
//  PromisesAndCaching
//
//  Created by Damian Esteban on 2/15/17.
//  Copyright © 2017 Damian Esteban. All rights reserved.
//

import Foundation

// Extension to merge dictionaries
extension Dictionary {

    func merged(with dictionary: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var copy = self
        dictionary.forEach {
            copy.updateValue($1, forKey: $0)
        }
        return copy
    }
    
}
