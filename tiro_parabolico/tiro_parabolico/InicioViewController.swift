//
//  InicioViewController.swift
//  tiro_parabolico
//
//  Created by José Luis Carvajal Carbajal on 3/28/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit

class InicioViewController: UIViewController {

    @IBOutlet weak var btnPreguntas: UIButton!
    @IBOutlet weak var btnSimulacion: UIButton!
    @IBOutlet weak var btnAcerca: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // setupGradient()
        
        let colorBg: UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.9)
        
        // Background color for buttons
        btnPreguntas.layer.backgroundColor = colorBg.cgColor
        btnSimulacion.layer.backgroundColor = colorBg.cgColor
        btnAcerca.layer.backgroundColor = colorBg.cgColor
        
        // Border for buttons
        btnPreguntas.layer.borderWidth = 1
        btnPreguntas.layer.borderColor = colorBg.cgColor
        btnPreguntas.layer.cornerRadius = 5
        btnSimulacion.layer.borderWidth = 1
        btnSimulacion.layer.borderColor = colorBg.cgColor
        btnSimulacion.layer.cornerRadius = 5
        btnAcerca.layer.borderWidth = 1
        btnAcerca.layer.borderColor = colorBg.cgColor
        btnAcerca.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*func setupGradient() {
        // Background color for view
        let colorTop = UIColor(red: 0, green: 0.2, blue: 1, alpha: 1)
        let colorBottom = UIColor(red: 0, green: 0.4, blue: 1, alpha: 0.7)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }*/

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func unwindAcerca(unwindSegue: UIStoryboardSegue) {
        
    }
    

}
