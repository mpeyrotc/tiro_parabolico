//
//  ButtonGradient.swift
//  tiro_parabolico
//
//  Created by José Luis Carvajal Carbajal on 4/24/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit

class ButtonGradient: UIButton {

    @IBInspectable var startColor: UIColor = UIColor.red // modificar
    @IBInspectable var endcolor: UIColor = UIColor.magenta // modificar
    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var disabledStartColor: UIColor = UIColor.red // modificar
    @IBInspectable var disabledEndcolor: UIColor = UIColor.magenta // modificar
    @IBInspectable var disabledBorderColor: UIColor = UIColor.black
    @IBInspectable var alphaForDisabled: CGFloat = 1
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        layer.masksToBounds = true
        
        if self.isEnabled == true {
            
            let myAlpha: CGFloat = 0.9
            
            borderColor = borderColor.withAlphaComponent(myAlpha)
            startColor = startColor.withAlphaComponent(myAlpha)
            endcolor = endcolor.withAlphaComponent(myAlpha)
            
            self.layer.borderWidth = 1
            self.layer.borderColor = borderColor.cgColor
            self.layer.cornerRadius = 5
            
            let contexto = UIGraphicsGetCurrentContext()
            
            let colores = [startColor.cgColor, endcolor.cgColor]
            
            let espacioColor = CGColorSpaceCreateDeviceRGB()
            
            let localizacionColor: [CGFloat] = [0.0, 1.0]
            
            let gradiente = CGGradient(colorsSpace: espacioColor, colors: colores as CFArray, locations: localizacionColor)
            
            let puntoInicio = CGPoint.zero
            let puntoFin = CGPoint(x: 0, y: self.bounds.height)
            
            contexto?.drawLinearGradient(gradiente!, start: puntoInicio, end: puntoFin, options: CGGradientDrawingOptions.drawsAfterEndLocation)
            
        } else {
            
            alphaForDisabled = 0.5
            
            disabledBorderColor = disabledBorderColor.withAlphaComponent(alphaForDisabled)
            disabledStartColor = disabledStartColor.withAlphaComponent(alphaForDisabled)
            disabledEndcolor = disabledEndcolor.withAlphaComponent(alphaForDisabled)
            
            self.layer.borderWidth = 1
            self.layer.borderColor = disabledBorderColor.cgColor
            self.layer.cornerRadius = 5
            
            
            let contexto = UIGraphicsGetCurrentContext()
            
            let colores = [disabledStartColor.cgColor, disabledEndcolor.cgColor]
            
            let espacioColor = CGColorSpaceCreateDeviceRGB()
            
            let localizacionColor: [CGFloat] = [0.0, 1.0]
            
            let gradiente = CGGradient(colorsSpace: espacioColor, colors: colores as CFArray, locations: localizacionColor)
            
            let puntoInicio = CGPoint.zero
            let puntoFin = CGPoint(x: 0, y: self.bounds.height)
            
            contexto?.drawLinearGradient(gradiente!, start: puntoInicio, end: puntoFin, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        }
        
       
        
        
        
    }


}
