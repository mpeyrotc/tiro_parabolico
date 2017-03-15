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
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    var yAxis: [Int]!
    var lineChartDataSet = LineChartDataSet()
    var lineChartData = LineChartData()
    var index:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        yAxis = []
        setChart(yValues: yAxis)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setChart(yValues: [Int]){
        
        var dataInput: [ChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(yValues[i]))
            dataInput.append(dataEntry)
        }
        
        lineChartDataSet = LineChartDataSet(values: dataInput, label: "Altura")
        lineChartDataSet.circleRadius = 2
        lineChartDataSet.circleColors = [NSUIColor.black]
        lineChartDataSet.lineWidth = 5
        lineChartDataSet.colors = [NSUIColor.black]
        lineChartDataSet.drawValuesEnabled = false
        lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        lineChartView.animate(xAxisDuration: 1)
        
    }
    
    @IBAction func update(_ sender: UIStepper) {
        let value = Int(sender.value)
        if yAxis.count < value {
            yAxis.append(value - 1)
            index += 1
        } else {
            yAxis.removeLast()
            index -= 1
        }
        setChart(yValues: yAxis)
    }
    
}

