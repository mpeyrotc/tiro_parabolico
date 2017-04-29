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
    @IBOutlet weak var valueTimeTextField: UITextField!
    @IBOutlet weak var sgUnits: UISegmentedControl!
    @IBOutlet weak var xLimitTextField: UITextField!
    @IBOutlet weak var timeLimitTextField: UITextField!
    @IBOutlet weak var btnGraficar: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewVistaEnScroll: UIView!
    @IBOutlet weak var sgcUnits: UISegmentedControl!
    
    var activeField: UITextField?
    
    var units = "IS"
    var graficasPrevias = [Shot]()
    var xMenor:Double!
    var xMayor:Double!
    var alturaMayor:Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetValues()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ParametrosViewController.removeKeyboard))
        
        viewVistaEnScroll.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        sgcUnits.tintColor = UIColor(red: 0.71, green: 0.0039, blue: 0, alpha: 1)
    
            self.view.addGestureRecognizer(tap)
        
        self.registrarseParaNotificacionesDeTeclado()
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
            // Limites
            animationView.xLimit = xLimitTextField.text!
            animationView.timeLimit = timeLimitTextField.text!
            animationView.graficasPrevias = graficasPrevias
            animationView.xMayor = xMayor
            animationView.xMenor = xMenor
            animationView.alturaMayor = alturaMayor
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        // Solo puede haber un limite con valor
        if sender as! UIButton == btnGraficar {
            // checar que haya datos en los parametros y solo un limite
            if (xLimitTextField.text != "" || timeLimitTextField.text != "") {
                if (xLimitTextField.text != "" && timeLimitTextField.text != "") {
                    let alerta = UIAlertController(title: "Error", message: "Solo uno de los limites  puede tener valor", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    present(alerta, animated: true, completion: nil)
                    return false
                }
            }
            
            // Checar que solo se trate de valores numericos
            if Double(startXPosTextField.text!) == nil {
                let alerta = UIAlertController(title: "Error", message: "La posición inicial en X tiene un formato no numérico o inválido. Corrígalo y vuelva a intentarlo.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            } else if Double(startYPosTextField.text!) == nil {
                let alerta = UIAlertController(title: "Error", message: "La posición inicial en Y tiene un formato no numérico o inválido. Corrígalo y vuelva a intentarlo.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            } else if Double(initialVelocityTextField.text!) == nil {
                let alerta = UIAlertController(title: "Error", message: "La velocidad inicial tiene un formato no numérico o inválido. Corrígalo y vuelva a intentarlo.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            } else if Double(shotAngleTextField.text!) == nil {
                let alerta = UIAlertController(title: "Error", message: "El ángulo inicial tiene un formato no numérico o inválido. Corrígalo y vuelva a intentarlo.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            } else if xLimitTextField.text != "" && Double(xLimitTextField.text!) == nil {
                let alerta = UIAlertController(title: "Error", message: "El límite en distancia X tiene un formato no numérico o inválido. Corrígalo y vuelva a intentarlo.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            } else if timeLimitTextField.text != "" && Double(timeLimitTextField.text!) == nil {
                let alerta = UIAlertController(title: "Error", message: "El límite en tiempo tiene un formato no numérico o inválido. Corrígalo y vuelva a intentarlo.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            }
            
            // Checar que solo se trate de valores positivos
            if Double(startYPosTextField.text!)! < 0 ||
                    Double(initialVelocityTextField.text!)! < 0 ||
                    Double(shotAngleTextField.text!)! < 0 ||
                    (timeLimitTextField.text != "" && Double(timeLimitTextField.text!)! < 0) ||
                    (xLimitTextField.text != "" && Double(xLimitTextField.text!)! < 0) {
                
                let alerta = UIAlertController(title: "Error", message: "Todos los campos deben tener valores positivos.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            }
            
            
            // Checar que el angulo de tiro se encuentre en el ángulo
            // apropiado
            if Double(shotAngleTextField.text!)! > 90 && Double(shotAngleTextField.text!)! < 270 {
                let alerta = UIAlertController(title: "Error", message: "El ángulo de tiro solo puede ser de 0 a 90 grados y de 270 a 360 grados.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false

            }
            
            
        }
        return true
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
    
    
    //Funcion para actualizar el arreglo de graficas.
    func actualizaPrevio(valores: [Shot]){
        graficasPrevias = valores
    }
    
    /*
     Funcion para reiniciar el arreglo de las graficas que habian sido previamente
    pintadas, con la opcion de cancelar la accion si el usuario no desea continuar
     con la decision de borrar las graficas.
    */
    @IBAction func borraGraficas(_ sender: UIBarButtonItem) {
        if sender.tag == 1{
            /*
             var refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
             
             refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
             print("Handle Ok logic here")
             }))
             
             refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
             print("Handle Cancel Logic here")
             }))
             
             presentViewController(refreshAlert, animated: true, completion: nil)
            */
            let alertaBorrar = UIAlertController(title: "Reinicia", message: "Se borraran las graficas previamente utilizadas", preferredStyle: UIAlertControllerStyle.alert)
            alertaBorrar.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action: UIAlertAction!) in
            self.graficasPrevias.removeAll()
            self.xMenor = nil
            self.xMayor = nil
            self.alturaMayor = nil
            }))
            alertaBorrar.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            present(alertaBorrar, animated: true, completion: nil)
        }
    }
    
    // MARK: - Keyboard methods
    
    @IBAction func removeKeyboard() {
        view.endEditing(true)
    }
    
    fileprivate func registrarseParaNotificacionesDeTeclado() {
        NotificationCenter.default.addObserver(self, selector:#selector(ParametrosViewController.keyboardWasShown(_:)),
                                               name:NSNotification.Name.UIKeyboardWillShow, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(ParametrosViewController.keyboardWillBeHidden(_:)),
                                               name:NSNotification.Name.UIKeyboardWillHide, object:nil)
    }
    
    func keyboardWasShown (_ aNotification : Notification )
    {
        let kbSize = ((aNotification as NSNotification).userInfo![UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        
        let contentInset = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        var bkgndRect : CGRect = scrollView.frame
        bkgndRect.size.height += kbSize.height;
        
        activeField!.superview!.frame = bkgndRect;
        scrollView.setContentOffset(CGPoint(x: 0.0, y: self.activeField!.frame.origin.y-kbSize.height), animated: true)
    }
    
    func keyboardWillBeHidden (_ aNotification : Notification)
    {
        let contentInsets : UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
    
    // OJO poner atención a este comentario
    // Each text field in the interface sets the view controller as its delegate.
    // Therefore, when a text field becomes active, it calls these methods.
    
    func textFieldDidBeginEditing (_ textField : UITextField )
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing (_ textField : UITextField )
    {
        activeField = nil
    }
}
