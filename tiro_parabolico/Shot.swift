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
    let GRAVITY_EN = -32.0
    private let initialVelocity: Double!
    private let initialXPos: Double!
    private let initialYPos: Double!
    private let angle: Double!
    private var units = "IS"
    
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
        
        var result: Double!
        if units == "IS" {
            result = initialYPos + (initialVelocity * sin(angle) * time) + (0.5 * GRAVITY * pow(time, 2))
        } else {
            result = initialYPos + (initialVelocity * sin(angle) * time) + (0.5 * GRAVITY_EN * pow(time, 2))
        }
        
        return result
    }
    
    /*
     * returns the whole amount of time that the projectile 
     * will take to reach y position = 0
     */
    public func finalTime() -> Double {
        var result: Double!
        
        if units == "IS" {
            result = ((initialVelocity * sin(angle)) / -GRAVITY) * 2
            
            if initialYPos > 0 {
                result = result! + sqrt(initialYPos * 2 / -GRAVITY)
            }
        } else {
            result = ((initialVelocity * sin(angle)) / -GRAVITY_EN) * 2
            
            if initialYPos > 0 {
                result = result! + sqrt(initialYPos * 2 / -GRAVITY_EN)
            }
        }
        
        return result
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
        var result: Double!
        
        if units == "IS" {
            result = (initialVelocity * sin(angle)) + (GRAVITY * time)
        } else {
            result = (initialVelocity * sin(angle)) + (GRAVITY_EN * time)
        }

        return result
    }
    
    public func getAngle() -> Double {
        return angle
    }
    
    public func getVelocity() -> Double {
        return initialVelocity
    }
    
    public func setUnits(_ units: String) -> Void {
        self.units = units
    }
    
    public func timeForX(_ x: Double) -> Double{
        // time is not used in getXVelocity so a zero is passed instead.
        return (x - getInitialXPos()) / (getXVelocity(0))
    }
}
