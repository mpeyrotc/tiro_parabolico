//
//  ViewController.swift
//  tiro_parabolico
//
//  Created by Marco Peyrot on 3/11/17.
//  Copyright © 2017 Marco Peyrot. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var yVelocityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    var yAxis = [Double]()
    var xAxis = [Double]()
    var index:Int = 1
    var shot: Shot!
    var initialVelocity: Double!
    var startX: Double!
    var startY: Double!
    var angle: Double!
    var valorPrevio:Double = 0.0
    var units: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generamos nuestro objeto "Shot" con los valores enviados
        shot = Shot(initialVelocity, startX, startY, angle)
        shot.setUnits(units)
        
        // Asignamos el primer punto en tiempo 0
        yAxis.append(shot.yForTime(0)!)
        xAxis.append(shot.xForTime(0)!)
        
        // Pintamos la grafica con el primer punto en tiempo 0
        setChart()
        
        // Imprimimos la informacion del objeto "shot" con tiempo 0
        if units == "IS" {
            yVelocityLabel.text = String(format: "%.2f m/s", shot.getYVelocity(0))
            distanceLabel.text = String(format: "%.2f m", shot.xForTime(0)!)
            heightLabel.text = String(format: "%.2f m", shot.yForTime(0)!)
        } else {
            yVelocityLabel.text = String(format: "%.2f f/s", shot.getYVelocity(0))
            distanceLabel.text = String(format: "%.2f f", shot.xForTime(0)!)
            heightLabel.text = String(format: "%.2f f", shot.yForTime(0)!)
        }
        
        timeLabel.text = String(format: "%.2f s", 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setChart(){
        
        var dataInput: [ChartDataEntry] = []
        
        // Introducimos los puntos
        for i in 0..<yAxis.count {
            let dataEntry = ChartDataEntry(x: xAxis[i], y: yAxis[i])
            dataInput.append(dataEntry)
        }
        
        // Establecemos el estilo de nuestra grafica
        let chartDataSet = LineChartDataSet(values: dataInput, label: "Altura")
        chartDataSet.circleRadius = 2
        chartDataSet.circleColors = [NSUIColor.black]
        chartDataSet.lineWidth = 5
        chartDataSet.colors = [NSUIColor.black]
        //––––––––––––––OPCIONAL LINEA PUNTEADA
        //chartDataSet.colors = [NSUIColor.clear]
        chartDataSet.drawValuesEnabled = false
        
        //Cargamos el estilo de la grafica al set de datos
        var dataSet: [IChartDataSet] = []
        dataSet.append(chartDataSet)
        
        //Creamos la grafica con el set de datos
        let chartData = LineChartData(dataSets: dataSet)
        
        //Se la asignamos al view para que muetre la grafica.
        lineChartView.data = chartData
        lineChartView.chartDescription!.text = ""
        
        
        //Formato de la grafica.
        
        //Formato del eje izquiero
        lineChartView.leftAxis.axisMinimum = 0.0
        lineChartView.leftAxis.axisMaximum = shot.yForTime(shot.finalTime()/2)! + 1
        
        //Formato del eje derecho
        lineChartView.rightAxis.enabled = false
        
        //Formato del eje inferior
        lineChartView.xAxis.axisMinimum = shot.getInitialXPos()
        lineChartView.xAxis.axisMaximum = shot.xForTime(shot.finalTime())!
    }
    
    @IBAction func update(_ sender: UIStepper) {
        // Valor del stepper
        let value = sender.value
        
        /*
         Valor del ultimo segundo posible antes de tocar 0 en altura
         el "ceil" es para darle margen a la grafica y que se pueda
         apreciar mejor
         */
        let segundoFinal = ceil(shot.finalTime())
        
        /*
         Si el valor del stepper es menor o igual al ultimo segundo
         podemos pintar mas puntos
         */
        if value <= segundoFinal {
            
            /*
             Si el valor del stepper incremento pintamos el siguiente segundo
             */
            if value > valorPrevio {
                
                /*
                 Este ciclo sirve para pintar 10 puntos entre el segundo
                 "x" y el segundo "y" inclusivos
                 */
                for index in stride(from: valorPrevio, to: value, by: 0.1){
                    yAxis.append(shot.yForTime(Double(index))!)
                    xAxis.append(shot.xForTime(Double(index))!)
                }
                
                //Actualizamos el valor previo
                valorPrevio = value
                
            } else if value < valorPrevio {
                
                /*
                 Este ciclo es para eliminar los ultimos 10 puntos pintados
                 */
                for _ in 1...10 {
                    yAxis.removeLast()
                    xAxis.removeLast()
                }
                
                //Actualizamos el valor previo
                valorPrevio = value
            }
        }
        
        //Pintamos la nueva grafica
        setChart()
        
        // Informacion del objeto shot
        
        /*
         Si el stepper se pasa del ultimo segundo, no redondeado,
         Entonces imprimimos la informacion en el ultimo segundo cuando llega
         a  y = 0
         ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
         Si no, entonces imprimimos los valores en el tiempo que el stepper nos
         marque
         */
        if value > shot.finalTime() {
            timeLabel.text = String(format: "%.2f s", shot.finalTime())
            if units == "IS" {
                yVelocityLabel.text = String(format: "%.2f m/s", shot.getYVelocity(shot.finalTime()))
                distanceLabel.text = String(format: "%.2f m", shot.xForTime(shot.finalTime())!)
                heightLabel.text = String(format: "%.2f m", shot.yForTime(shot.finalTime())!)
            } else {
                yVelocityLabel.text = String(format: "%.2f f/s", shot.getYVelocity(shot.finalTime()))
                distanceLabel.text = String(format: "%.2f f", shot.xForTime(shot.finalTime())!)
                heightLabel.text = String(format: "%.2f f", shot.yForTime(shot.finalTime())!)
            }
            sender.value = segundoFinal
        } else {
            timeLabel.text = String(format: "%.2f s", sender.value)
            if units == "IS" {
                yVelocityLabel.text = String(format: "%.2f m/s", shot.getYVelocity(sender.value))
                distanceLabel.text = String(format: "%.2f m", shot.xForTime(sender.value)!)
                heightLabel.text = String(format: "%.2f m", shot.yForTime(sender.value)!)
            } else {
                yVelocityLabel.text = String(format: "%.2f f/s", shot.getYVelocity(sender.value))
                distanceLabel.text = String(format: "%.2f f", shot.xForTime(sender.value)!)
                heightLabel.text = String(format: "%.2f f", shot.yForTime(sender.value)!)
            }
        }
    }
    
}
