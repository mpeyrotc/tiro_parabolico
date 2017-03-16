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
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var questionTextArea: UITextView!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    var questions: NSArray!
    var currentQuestion = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetValues()
        questionTextArea.text = ""
        feedbackLabel.text = ""
        
        let path = Bundle.main.path(forResource: "Property List", ofType: "plist")
        questions = NSArray(contentsOfFile: path!)
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

    @IBAction func showNewQuestion(_ sender: Any) {
        currentQuestion = (currentQuestion + 1) % 5
        
        let dict = questions[currentQuestion] as! NSDictionary
        questionTextArea.text = dict.value(forKey: "Pregunta") as! String?
        
        feedbackLabel.text = ""
        answerTextField.text = ""
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        let dict = questions[currentQuestion] as! NSDictionary
        
        if answerTextField.text == (dict.value(forKey: "Respuesta") as! String) {
            feedbackLabel.text = "Correct!"
        } else {
            feedbackLabel.text = "Try again."
        }
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
