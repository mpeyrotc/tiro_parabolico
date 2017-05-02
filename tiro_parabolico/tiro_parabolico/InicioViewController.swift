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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func unwindAcerca(unwindSegue: UIStoryboardSegue) {
        
    }
    

}
