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
        self.angle = angle * 3.1416 / 180
    }
    
    /*
     * get the x postion of the projectile for time t, if the
     * time is less than 0 or more than the point where the projectile
     * reaches y position = 0, it returns nil.
     */
    public func xForTime(_ time: Double) -> Double? {
        if time < 0 {
            return nil
        }
        return initialXPos + (getXVelocity(time) * time)
    }
    
    /*
     * get the y postion of the projectile for time t, if the
     * time is less than 0 or more than the point where the projectile
     * reaches y position = 0, it returns nil.
     */
    public func yForTime(_ time: Double) -> Double? {
        if time < 0 {
            return nil
        }
        
        return initialYPos + (initialVelocity * sin(angle) * time) + (0.5 * GRAVITY * pow(time, 2))
    }
    
    /*
     * returns the whole amount of time that the projectile 
     * will take to reach y position = 0
     */
    public func finalTime() -> Double {
        return ((initialVelocity * sin(angle)) / -GRAVITY) * 2
    }
    
    /*
     * returns a list of x,y coordinates that span from start to end and are divided
     * by intervals of 1 unit.
     */
    public func positions(_ start: Double, _ end: Double) -> [(Double, Double)] {
        var result:[(Double, Double)] = []
        
        if start < 0 || end < start {
            return result
        }
        
        var i = start
        
        while(i <= end) {
            result.append((xForTime(i)!, yForTime(i)!))
            i += 1
        }
        
        return result
    }
    
    public func getInitialXPos() -> Double {
        return initialXPos
    }
    
    public func getInitialYPos() -> Double {
        return initialYPos
    }
    
    public func getXVelocity(_ time: Double) -> Double {
        return initialVelocity * cos(angle)
    }
    
    public func getYVelocity(_ time: Double) -> Double {
        return (initialVelocity * sin(angle)) + (GRAVITY * time)
    }
    
    public func getAngle() -> Double {
        return angle
    }
    
    public func getVelocity() -> Double {
        return initialVelocity
    }
}
