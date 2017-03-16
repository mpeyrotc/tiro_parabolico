//
//  MainViewController.swift
//  tiro_parabolico
//
//  Created by Marco Peyrot on 3/15/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var initialVelocityTextField: UITextField!
    @IBOutlet weak var startXPosTextField: UITextField!
    @IBOutlet weak var startYPosTextField: UITextField!
    @IBOutlet weak var shotAngleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetDefaultValues(_ sender: Any) {
        resetValues()
    }
    
    func resetValues() {
        initialVelocityTextField.text = String(20)
        startXPosTextField.text = String(0)
        startYPosTextField.text = String(0)
        shotAngleTextField.text = String(85)
    }

    
    // MARK: - Navigation

    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animationSegue" {
            let animationView = segue.destination as! ViewController
            
            animationView.initialVelocity = Double(initialVelocityTextField.text!)
            animationView.startX = Double(startXPosTextField.text!)
            animationView.startY = Double(startYPosTextField.text!)
            animationView.angle = Double(shotAngleTextField.text!)
        }
    }
    
    @IBAction func unwindAnimation(unwindSegue: UIStoryboardSegue) {
        // Does nothing, used to get back to this view
    }

}
