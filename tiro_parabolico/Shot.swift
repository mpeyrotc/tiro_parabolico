//
//  Shot.swift
//  tiro_parabolico
//
//  class that represents a single shot for parabolic motion.
//  It contains all the related state and functionality to get
//  data out of the shot in terms of attributes or time.
//
//  Created by Marco Peyrot on 3/13/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit

class Shot: NSObject {
    let GRAVITY = -9.81
    private let initialVelocity: Double!
    private let initialXPos: Double!
    private let initialYPos: Double!
    private let angle: Double!
    
    init(_ initialVelocity:Double, _ initialXPos:Double, _ initialYPos:Double, _ angle:Double) {
        self.initialVelocity = initialVelocity
        self.initialXPos = initialXPos
        self.initialYPos = initialYPos
        self.angle = angle
    }
    
    /*
     * get the x postion of the projectile for time t, if the
     * time is less than 0 or more than the point where the projectile
     * reaches y position = 0, it returns nil.
     */
    public func xForTime(_ time: Double) -> Double? {
        if time < 0 || time > finalTime() {
            return nil
        }
        return initialXPos + (initialVelocity * cos(angle) * time)
    }
    
    public func yForTime(_ time: Double) -> Double? {
        if time < 0 || time > finalTime() {
            return nil
        }
        
        return initialYPos + (initialVelocity * sin(angle)) + (0.5 * GRAVITY * pow(time, 2))
    }
    
    public func finalTime() -> Double {
        return (initialVelocity * sin(angle)) / -GRAVITY
    }
    
    public func positions(_ start: Double, _ end: Double) -> [(Double, Double)] {
        if start < 0 {
        }
        
        var result:[(Double, Double)] = []
        var i = start
        
        while(i <= end) {
            result.append((xForTime(i)!, yForTime(i)!))
            i += 1
        }
        
        return result
    }
}
