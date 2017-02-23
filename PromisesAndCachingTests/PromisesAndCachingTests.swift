//
//  PromisesAndCachingTests.swift
//  PromisesAndCachingTests
//
//  Created by Damian Esteban on 2/11/17.
//  Copyright © 2017 Damian Esteban. All rights reserved.
//

import XCTest
import DVR
import then
@testable import PromisesAndCaching

class PromisesAndCachingTests: XCTestCase {
    
    let service = NetworkService(session: Session(cassetteName: "testy"))
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let d = [String: Any]()
        let task = service.fetchOne(dictionary: d)
        task.then { json in
            print(json)
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
