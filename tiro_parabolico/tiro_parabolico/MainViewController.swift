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
    var currentAnswer: Double!

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
        //currentQuestion = Int(arc4random_uniform(UInt32(questions.count)))
        currentQuestion = 1
        let dict = questions[currentQuestion] as! NSDictionary
        
        // Create new question
        var question:String = dict.value(forKey: "Pregunta") as! String
        let subtype = dict.value(forKey: "SUBTYPE") as! String
        
        switch subtype {
        case "DIST_GROUND":
            let velocity = Int(arc4random_uniform(30) + 1)
            let height = Int(arc4random_uniform(30) + 1)
            question = question.replacingOccurrences(of: "VELOCIDAD", with: String(velocity))
            question = question.replacingOccurrences(of: "ALTURA", with: String(height))
            
            let time = (Double(velocity) * sin(0) + sqrt(pow(Double(velocity) * sin(0), 2) - 4.0 * (0.5 * -9.8) * Double(height))) / 9.8
            currentAnswer = (Double(velocity) * cos(0)) * time
            break
        case "DIST_TIME":
            let grados = Int(arc4random_uniform(76) + 10)
            let velocity = Int(arc4random_uniform(71) + 10)
            question = question.replacingOccurrences(of: "VELOCIDAD", with: String(velocity))
            question = question.replacingOccurrences(of: "GRADOS", with: String(grados))
            
            var time = 0.5
            let time2 = 2.0 * (Double(velocity) * sin(Double(grados) * 3.1416 / 180)) / 9.8
            
            if time2 < 0.5 {
                time = time2
            }
            
            currentAnswer = (Double(velocity) * cos(Double(grados) * 3.1416 / 180)) * time
            break
        default:
            // nothing
            print("error, never should have got here.")
        }
        
        // set question visible to the user
        questionTextArea.text = question
        feedbackLabel.text = ""
        answerTextField.text = ""
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        let dict = questions[currentQuestion] as! NSDictionary
        let type = dict.value(forKey: "TYPE") as! String
        var isCorrect:Bool = false
        
        if type == "DYNAMIC" {
            isCorrect = (abs(Double(answerTextField.text!)! - currentAnswer) < 0.1)
        } else {
            isCorrect = (answerTextField.text == (dict.value(forKey: "Respuesta") as! String))
        }
        
        if isCorrect {
            feedbackLabel.text = "Correcto!"
        } else {
            feedbackLabel.text = "Inténtelo otra vez."
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
