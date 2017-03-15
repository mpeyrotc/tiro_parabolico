//
//  tiro_parabolicoTests.swift
//  tiro_parabolicoTests
//
//  Created by Marco Peyrot on 3/11/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import XCTest
@testable import tiro_parabolico

class tiro_parabolicoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFinalTime() {
        let shot = Shot(20, 0, 0, 37)
        assert(abs(shot.finalTime() - 2.44) < 0.1)
    }
    
    func testDistance() {
        let shot = Shot(20, 0, 0, 37)
        assert(abs(shot.xForTime(2.44)! - 38.96) < 0.1)
    }
    
    func testYVelocity() {
        let shot = Shot(20, 0, 0, 37)
        assert(abs(shot.getYVelocity(1.0) - 2.23) < 0.1)
    }
    
    func testXVelocity() {
        let shot = Shot(20, 0, 0, 37)
        assert(abs(shot.getXVelocity(1.0) - 15.97) < 0.1)
    }
    
    func testMaxHeight() {
        let shot = Shot(20, 0, 0, 37)
        print("#####\(shot.yForTime(shot.finalTime() / 2.0)!)####")
        assert(abs(shot.yForTime(shot.finalTime() / 2)! - 7.38) < 0.1)
    }
    
    
}
