//: Playground - noun: a place where people can play

import UIKit
import then
var str = "Hello, playground"

struct NilError: Error { }

extension Optional {
    func unwrap() throws -> Wrapped {
        guard let result = self else {
            throw NilError()
        }
        return result
    }
}

var name: String? = "Balls"

try! name.unwrap()