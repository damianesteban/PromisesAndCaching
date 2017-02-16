//
//  Opttional+NilErrorUnwrap.swift
//  PromisesAndCaching
//
//  Created by Damian Esteban on 2/15/17.
//  Copyright © 2017 Damian Esteban. All rights reserved.
//

import Foundation

struct NilError: Error { }

extension Optional {
    func unwrap() throws -> Wrapped {
        guard let result = self else {
            throw NilError()
        }
        return result
    }
}
