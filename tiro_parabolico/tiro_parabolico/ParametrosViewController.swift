//
//  ParametrosViewController.swift
//  tiro_parabolico
//
//  Created by José Luis Carvajal Carbajal on 3/28/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit

class ParametrosViewController: UIViewController {

    @IBOutlet weak var initialVelocityTextField: UITextField!
    @IBOutlet weak var startXPosTextField: UITextField!
    @IBOutlet weak var startYPosTextField: UITextField!
    @IBOutlet weak var shotAngleTextField: UITextField!
    @IBOutlet weak var valueXTextField: UITextField!
    @IBOutlet weak var valueYTextField: UITextField!
    @IBOutlet weak var valueTimeTextField: UITextField!
    @IBOutlet weak var sgUnits: UISegmentedControl!
    @IBOutlet weak var xLimitTextField: UITextField!
    @IBOutlet weak var yLimitTextField: UITextField!
    @IBOutlet weak var timeLimitTextField: UITextField!
    
    var units = "IS"
    var graficasPrevias = [Shot]()
    var xMenor:Double!
    var xMayor:Double!
    var alturaMayor:Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Reset Values
    
    @IBAction func resetParemetros(_ sender: UIButton) {
        resetValues()
    }
    func resetValues() {
        initialVelocityTextField.text = String(20)
        startXPosTextField.text = String(0)
        startYPosTextField.text = String(0)
        shotAngleTextField.text = String(85)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "graficar" {
            let animationView = segue.destination as! ViewController
            
            animationView.initialVelocity = Double(initialVelocityTextField.text!)
            animationView.startX = Double(startXPosTextField.text!)
            animationView.startY = Double(startYPosTextField.text!)
            animationView.angle = Double(shotAngleTextField.text!)
            animationView.units = units
            animationView.xLimit = xLimitTextField.text!
            animationView.yLimit = yLimitTextField.text!
            animationView.timeLimit = timeLimitTextField.text!
            animationView.graficasPrevias = graficasPrevias
            animationView.xMayor = xMayor
            animationView.xMenor = xMenor
            animationView.alturaMayor = alturaMayor
        }
        
    }
    
    // relacionado con boton Atras
    @IBAction func regresar(_ sender: UIBarButtonItem) {
        guard(navigationController?.popViewController(animated: true)) != nil
            else {
                dismiss(animated: true, completion: nil)
                return
        }
    }
    
    // unwind del view controller de la grafica
    @IBAction func unwindParametros(unwindSegue: UIStoryboardSegue) {
        
    }
    
    
    @IBAction func changedUnits(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            units = "IS"
            break;
        case 1:
            units = "ENGLISH"
            break;
        default:
            break;
        }
    }
    
    func actualizaPrevio(valores: [Shot]){
        graficasPrevias = valores
    }
}
