//
//  Gradiente.swift
//  tiro_parabolico
//
//  Created by José Luis Carvajal Carbajal on 4/24/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit

class Gradiente: UIView {

    @IBInspectable var startColor: UIColor = UIColor.blue // modificar
    @IBInspectable var endcolor: UIColor = UIColor.green // modificar
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let contexto = UIGraphicsGetCurrentContext()
        
        let colores = [startColor.cgColor, endcolor.cgColor]
        
        let espacioColor = CGColorSpaceCreateDeviceRGB()
        
        let localizacionColor: [CGFloat] = [0.0, 1.0]
        
        let gradiente = CGGradient(colorsSpace: espacioColor, colors: colores as CFArray, locations: localizacionColor)
        
        let puntoInicio = CGPoint.zero
        let puntoFin = CGPoint(x: 0, y: self.bounds.height)
        contexto?.drawLinearGradient(gradiente!, start: puntoInicio, end: puntoFin, options: CGGradientDrawingOptions.drawsAfterEndLocation)
    }
    


}
