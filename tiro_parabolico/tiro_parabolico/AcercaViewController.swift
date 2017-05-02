//
//  AcercaViewController.swift
//  tiro_parabolico
//
//  Created by José Luis Carvajal Carbajal on 3/29/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit
import QuartzCore

class AcercaViewController: UIViewController {

    @IBOutlet weak var btnAtras: UIButton!
    @IBOutlet weak var tvDescripcion: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvDescripcion.layer.borderWidth = 2
        tvDescripcion.layer.cornerRadius = 5;
        
        //UIColor.red.cgColor
        let defaultColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha:1)
        btnAtras.layer.borderWidth = 1
        btnAtras.layer.borderColor = defaultColor.cgColor
        btnAtras.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return UIInterfaceOrientationMask.landscape
        
    }
    
    override var shouldAutorotate: Bool {
        
        return false
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
